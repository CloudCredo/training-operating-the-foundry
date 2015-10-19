require 'json'

module CF::App
  class Service #:nodoc:
    class << self
      def find_by_name(name)
        all.detect do |service|
          service['name'] == name
        end
      end

      def find_by_tag(tag)
        find_all_by_tag(tag).first
      end

      def find_all_by_tag(tag)
        all.select do |service|
          service['tags'].include?(tag)
        end
      end

      def find_all_by_tags(tags)
        all.select do |service|
          tags.inject(true) do |contains_all_tags, tag|
            contains_all_tags && service['tags'] && service['tags'].include?(tag)
          end
        end
      end

      def find_by_label(label)
        find_all_by_label(label).first
      end

      def find_all_by_label(label)
        all.select do |service|
          service['label'].match /^#{label}(-.*)?$/
        end
      end

      private

      def all
        @services ||= JSON.parse(ENV['VCAP_SERVICES']).values.flatten
      end
    end
  end
end
