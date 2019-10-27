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

        path = Pathname.new(path)
        unless path.exist?
          raise Informative, "No podspec exists at path `#{path}`."
        end

        string = File.open(path, 'r:utf-8', &:read)
        # Work around for Rubinius incomplete encoding in 1.9 mode
        if string.respond_to?(:encoding) && string.encoding.name != 'UTF-8'
          string.encode!('UTF-8')
        end

        pod_object = JSON.parse(string)
        if (pod_object['source'] && pod_object['source']['http'])
          pod_object['source']['http'] = process_source_http_url(pod_object['source']['http'], pod_object['version'])
          string = pod_object.to_json
        end

        from_string(string, path, subspec_name)
      end

      def process_source_http_url(url, version)

        if url != nil then
          if url.include? 'ios-lib.oss-cn-beijing.aliyuncs.com' then
            uri = URI.parse(url)
            oss_file_object_key = uri.path
            if $endpoint.nil? || $access_key_id.nil? || $access_key_secret.nil?
              raise("未设置全局变量：$endpoint $access_key_id $access_key_secret")
            end

            client = Aliyun::OSS::Client.new(endpoint: $endpoint,
                                             access_key_id: $access_key_id,
                                             access_key_secret: $access_key_secret);

            bucket = client.get_bucket('ios-lib')
            oss_url = bucket.object_url(oss_file_object_key[1...oss_file_object_key.length] + "-#{version}.zip")

            return oss_url
          end
        end

        return url
      end
    end
  end
end