module CF::App
  class Credentials
    class << self
      # Returns credentials for the service instance with the given +name+.
      def find_by_service_name(name)
        service = Service.find_by_name(name)
        service['credentials'] if service
      end

      # Returns credentials for the first service instance with the given +tag+.
      def find_by_service_tag(tag)
        service = Service.find_by_tag(tag)
        service['credentials'] if service
      end

      def find_all_by_service_tag(tag)
        services = Service.find_all_by_tag(tag)
        services.map do |service|
          service['credentials']
        end
      end

      # Returns credentials for the service instances with all the given +tags+.
      def find_all_by_all_service_tags(tags)
        return [] if tags.empty?

        Service.find_all_by_tags(tags).map { |service| service['credentials'] }
      end

      # Returns credentials for the first service instance with the given +label+.
      def find_by_service_label(label)
        service = Service.find_by_label(label)
        service['credentials'] if service
      end

      # Returns credentials for all service instances with the given +label+.
      def find_all_by_service_label(label)
        services = Service.find_all_by_label(label)
        services.map do |service|
          service['credentials']
        end
      end
    end
  end
end
