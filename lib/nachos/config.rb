class Nachos
  class Config

    def repo_root
      Pathname(config.repo_root).expand_path
    end
    
    def config
      config_exists? ? load_config : default_config
    end

    def display_config
      config_exists? ? load_config : "No config found - run nachos config to create one"    
    end
    
    def config_exists?
      config_path.exist?
    end
    
    def config_path
      Pathname(ENV["HOME"]).join(".nachos")
    end

    def default_config
      @default_config ||= Hashie::Mash.new("repo_root" => "#{ENV["HOME"]}/src")
    end

    def create_file
      File.open(config_path, "w") { |f| YAML.dump(default_config, f) }
      "created config file: #{config_path}"
    end
    
    def load_config
      Hashie::Mash.new(YAML.load_file(config_path))
    end
    
  end
end
