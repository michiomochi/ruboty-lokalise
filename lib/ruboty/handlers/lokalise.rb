# frozen_string_literal: true

module Ruboty
  module Handlers
    class Lokalise < Base
      on(
        /lokalise stats project "(?<project_name>.+)" languages "(?<language_iso_list>.+)"\z/,
        name: "translation_stats",
        description: "Show translation stats for specified project",
      )

      def translation_stats(message)
        project_name = message[:project_name]
        language_iso_list = message[:language_iso_list].split(",")
        project = project_find_by_name(name: project_name)
        statistics = project.statistics

        language_text =
          statistics["languages"].map do |language|
            iso = language["language_iso"]

            unless language_iso_list.include?(iso)
              next
            end

            words_to_do_count = language['words_to_do']
            emoji_symbol = issue_status_emoji_symbol(issue_count: words_to_do_count)
            "#{iso} untranslated: #{words_to_do_count} #{emoji_symbol}"
          end.compact.join("\n")

        qa_issues_count = statistics['qa_issues_total']

        reply_messages = [
          "#{project_name} translation stats",
          "qa_issues: #{qa_issues_count} #{issue_status_emoji_symbol(issue_count: qa_issues_count)}",
          language_text,
        ]

        message.reply(reply_messages.join("\n"))
      end

      private def client
        @client ||= ::Lokalise.client(ENV["LOKALISE_ACCESS_TOKEN"])
      end

      private def project_find_by_name(name:)
        client.projects.collection.find do |project|
          project.name == name
        end
      end

      private def issue_status_emoji_symbol(issue_count:)
        if issue_count > 0
          ":warning:"
        else
          ":ok_hand:"
        end
      end
    end
  end
end
