class Nachos::CLI < Thor

  attr_reader :main
  class_option :dry_run, :type => :boolean, :default => false, :desc => "If specified, the converter will just print the commands and not actually execute them"
  
  def initialize(*args)
    @main = Nachos::Main.new(self)
    super
  end
  
  desc "info", "Displays current setup for Nachos"
  def info
    shell.say main.info
  end
  
  desc "watched", "Display your watched repos on Github"
  def watched
    main.watched.each do |repo|
      shell.say "#{repo.owner}/#{repo.name} - #{repo.description}"
    end
  end
  
  desc "owned", "Display your owned repos on Github"
  def owned
     main.owned.each do |repo|
      shell.say "#{repo.name} - #{repo.description}"
    end
  end
  
  desc "sync", "Sync my watched repositories"
  def sync
    shell.say main.github_summary
    main.sync main.watched
  end

  desc "sync_owned", "Sync only my owned repositories"
  def sync_owned
    shell.say main.github_summary
    main.sync main.owned
  end
  
  desc "config", "Create default config (if it doesn't exist)"
  def config
    shell.say main.config.create_file
  end
  
  private
  
  def dry_run?
    options[:dry_run]
  end
  
end