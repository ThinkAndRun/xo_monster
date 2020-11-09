module ClientApi::V1
  module XoSessions
    class MakeStepService < ::SaveServices::UpdateService

      def self.perform(*args)
        new(*args).perform
      end

      def perform
        check_can_make_step!
        save_object
        broadcast_changed_xo_session
        success_result data: { xo_session: object }
      rescue StandardError => e
        puts e.message
        error_result message: e.message
      end

      private

      def broadcast_changed_xo_session
        ApplicationCable::XoSessionChangesChannel.broadcast_to(
            object,
            ClientApi::V1::XoSessionSerializer.new(object).to_json
        )
      end

      def permitted_attributes
        { steps: object.steps << new_step, last_step_at: Time.now }.merge!(opponent)
      end

      def mark
        object.reload.current_step_mark
      end

      def new_step
        params.permit(:r, :c).merge!({ m: mark }).to_h.with_indifferent_access
      end

      def check_can_make_step!
        raise 'Not user' unless current_user
        if mark == 'X'
          raise 'Not X user' if (object.x_user && object.x_user != current_user) || object.o_user == current_user
        else
          raise 'Not O user' if (object.o_user && object.o_user != current_user) || object.x_user == current_user
        end
        raise 'Board filled here' if !object.board.can_make_step?(new_step)
        raise 'Finished' if object.board.finished?
      end

      def opponent
        if !object.x_user || !object.o_user
          return { x_user_id: current_user.id } if !object.x_user && object.o_user != current_user
          return { o_user_id: current_user.id } if !object.o_user && object.x_user != current_user
        end
        {}
      end
    end
  end
end
