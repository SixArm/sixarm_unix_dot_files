###
# IRB RC for Rails
#
# Thanks to http://rakeroutes.com/blog/customize-your-irb/
#
# To make these work, add this to your Rails Gemfile:
#
#    group :development do
#      gem "awesome_print"
#      gem "hirb"
#      gem "interactive_editor"
#    end
###

rails_flag = ENV.include?('RAILS_ENV') || defined? Rails
console_flag = IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers')
rails_console_flag = rails_flag && console_flag

if rails_flag

if rails_console_flag
  require 'logger'
  Object.const_set(:RAILS_DEFAULT_LOGGER, Logger.new(STDOUT))
end

# set a nice prompt
rails_root = File.basename(Dir.pwd)
IRB.conf[:PROMPT] ||= {}
IRB.conf[:PROMPT][:RAILS] = {
  :PROMPT_I => "#{rails_root}> ", # normal prompt
  :PROMPT_S => "#{rails_root}* ", # prompt when continuing a string
  :PROMPT_C => "#{rails_root}? ", # prompt when continuing a statement
  :RETURN   => "=> %s\n"          # prefixes output
}
IRB.conf[:PROMPT_MODE] = :RAILS


### HIRB

# hirb: some nice stuff for Rails
begin
  require 'hirb'
  HIRB_LOADED = true
rescue LoadError
  HIRB_LOADED = false
end

require 'logger'

def loud_logger
  enable_hirb
  set_logger_to Logger.new(STDOUT)
end

def quiet_logger
  disable_hirb
  set_logger_to nil
end

def set_logger_to(logger)
  ActiveRecord::Base.logger = logger
  ActiveRecord::Base.clear_reloadable_connections!
end

def enable_hirb
  if HIRB_LOADED
    Hirb::Formatter.dynamic_config['ActiveRecord::Base']
    Hirb.enable
  else
    puts "hirb is not loaded"
  end
end

def disable_hirb
  if HIRB_LOADED
    Hirb.disable
  else
    puts "hirb is not loaded"
  end
end

# turn on the loud logging by default
IRB.conf[:IRB_RC] = Proc.new { loud_logger }

end