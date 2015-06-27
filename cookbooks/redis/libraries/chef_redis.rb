module ChefRedis
  class << self
    def template_format(key, v)
      k = format_key(key)
      case v
      when TrueClass
        "#{k} yes"
      when FalseClass
        "#{k} no"
      when Array
        v.map{|value| template_format(k, value) }.join("\n")
      else
        "#{k} #{v}"
      end
    end

    def format_key(k)
      k.to_s.gsub('_', '-')
    end

    def get_installed_version
      return @@version if @@version # Only shell out once per run
      @@version = %x{
        #{File.join(node.redis.dst_dir, 'bin/redis-server')} --version
      }.scan(/v=((\d+\.?){3})/).flatten.first
    end

    def set_installed_version(node)
      node.normal.redis.installed_version = get_installed_version
    end
  end
end
