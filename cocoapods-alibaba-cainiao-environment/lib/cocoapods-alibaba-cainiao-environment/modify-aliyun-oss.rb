module Pod
  class Specification
    class << self
      alias_method :new_from_file, :from_string
    end

    def self.new_from_file(path, subspec_name = nil)
      puts 'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk'
      old_from_file(path, subspec_name);
    end

    def self.old_from_file(path, subspec_name = nil)
      puts 'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk'
    end

  end
end