# frozen_string_literal: true

module SlashCommand
  module Commands
    class Out < Template
      HELP = "This command will stop the last activity.".freeze
      STOP_SUCCESS_MSG = "You just took a break. Move on! :smiley:".freeze
      ACTIVITY_NOT_RUNNING_MSG = "Hey, what's going on? Let's start an activity first! (e.g: `/tt in <NOTE>`)".freeze

      def call
        response.result = result
      end

      def self.description
        HELP
      end

      private

      def result
        return HELP if help?
        return running_activity? ? result_with_activity : ACTIVITY_NOT_RUNNING_MSG
      end

      def result_with_activity
        time_entry = user.time_entries.last
        time_entry.update_attributes(end: Time.current)
        STOP_SUCCESS_MSG
      end

      def running_activity?
        user.time_entries.where(end: nil).exists?
      end

    end
  end
end
