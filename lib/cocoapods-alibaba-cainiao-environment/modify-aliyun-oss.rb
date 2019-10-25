require 'aliyun/oss'

module Pod
  class Specification
    class << Specification
      alias_method :old_from_string, :from_file

      def from_file(path, subspec_name = nil)
        Dir.chdir(path.parent.directory? ? path.parent : Dir.pwd) do
          case path.extname
          when '.json'
          else
            old_from_string(path, subspec_name)
            return
          end
        end

        # puts 'gggggggggg ' + path.to_s
        path = Pathname.new(path)
        unless path.exist?
          raise Informative, "No podspec exists at path `#{path}`."
        end

        string = File.open(path, 'r:utf-8', &:read)
        # Work around for Rubinius incomplete encoding in 1.9 mode
        if string.respond_to?(:encoding) && string.encoding.name != 'UTF-8'
          string.encode!('UTF-8')
        end

        podObject = JSON.parse(string)

        if (podObject['source'] && podObject['source']['http'])
          # puts path.to_s
          process_source_http_url(podObject['source']['http'])
        end

        from_string(string, path, subspec_name)
      end

      def process_source_http_url(url)
        if url != nil then
          if url.include? 'test-user2.oss-cn-beijing.aliyuncs.com' then
            uri = URI.parse(url)
            oss_file_object_key = uri.path
            client = Aliyun::OSS::Client.new(endpoint: $endpoint,
                                             access_key_id: $access_key_id,
                                             access_key_secret: $access_key_secret);

            bucket = client.get_bucket('test-user2')
            uri = URI.parse(url)
            oss_url = bucket.object_url(uri.path[1...uri.path.length])
            puts 'oss_url = ' + oss_url

            return oss_url
          end
        end

        return url
      end

    end
  end
end