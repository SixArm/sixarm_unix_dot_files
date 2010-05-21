##
# IRB RC file for joelparkerhenderson@gmail.com
#
# This file uses these gems:
#   sudo gem install dbi
#   sudo gem install looksee
#   sudo gem install wirble
#
# This file will require each of these gems,
# and skip it if the gem doesn't exist.
    
script_console_running = ENV.include?('RAILS_ENV') && IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers')
rails_running = ENV.include?('RAILS_ENV') && !(IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers'))
irb_standalone_running = !script_console_running && !rails_running

if script_console_running
  require 'logger'
  Object.const_set(:RAILS_DEFAULT_LOGGER, Logger.new(STDOUT))
end

####

require 'rubygems'
require 'pp'
require 'benchmark'
require 'yaml'

begin
 require 'irb/completion'
rescue LoadError
end

begin
 require 'dbi'
rescue LoadError
end

begin
 require 'looksee/shortcuts'
rescue LoadError
end

begin
 require 'wirble'
 Wirble.init
 Wirble.colorize
rescue LoadError
end

####

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

####

# Simple demo objects, useful for quick testing
a1=['e1','e2','e3'] unless defined?(a1)
a2=['e3','e4','e5'] unless defined?(a2)
a3=['e6','e7','e8'] unless defined?(a3)
h1={'k1'=>'v1','k2'=>'v2','k3'=>'v3'} unless defined?(h1)
h2={'k4'=>'v4','k5'=>'v5','k6'=>'v6'} unless defined?(h2)
h3={'k7'=>'v7','k8'=>'v8','k9'=>'v9'} unless defined?(h3)
s1="hello world"
s2="lorem ipsum"
s3="foo bar"

####

# From http://pastie.org/179534

# Quick benchmarking
def quick(repetitions=10, *blocks)
  require 'benchmark'

  Benchmark.bmbm {|b|
    blocks.each {|block|
      b.report {repetitions.times &block} 
    }  
  }
  nil
end

# RI access
def ri(obj = '')
  puts `ri #{obj}`
end  

def reset_irb()
  exec $0
end

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true

####

# IRB RI fast completion
# http://eigenclass.org/hiki/irb+ri+completion

require 'irb/completion'

module Kernel
  def r(arg)
    puts `fri "#{arg}"`
  end
  private :r
end

class Object
  def puts_ri_documentation_for(obj, meth)
    case self
    when Module
      candidates = ancestors.map{|klass| "#{klass}::#{meth}"}
      candidates.concat(class << self; ancestors end.map{|k| "#{k}##{meth}"})
    else
      candidates = self.class.ancestors.map{|klass|  "#{klass}##{meth}"}
    end
    candidates.each do |candidate|
      #puts "TRYING #{candidate}"
      desc = `fri '#{candidate}'`
      unless desc.chomp == "nil"
      # uncomment to use ri (and some patience)
      #desc = `ri -T '#{candidate}' 2>/dev/null`
      #unless desc.empty?
        puts desc
        return true
      end
    end
    false
  end
  private :puts_ri_documentation_for

  def method_missing(meth, *args, &block)
    if md = /ri_(.*)/.match(meth.to_s)
      unless puts_ri_documentation_for(self,md[1])
        "Ri doesn't know about ##{meth}"
      end
    else
      super
    end
  end

  def ri_(meth)
    unless puts_ri_documentation_for(self,meth.to_s)
      "Ri doesn't know about ##{meth}"
    end
  end
end

RICompletionProc = proc{|input|
  bind = IRB.conf[:MAIN_CONTEXT].workspace.binding
  case input
  when /(\s*(.*)\.ri_)(.*)/
    pre = $1
    receiver = $2
    meth = $3 ? /\A#{Regexp.quote($3)}/ : /./ #}
    begin
      candidates = eval("#{receiver}.methods", bind).map do |m|
        case m
        when /[A-Za-z_]/; m
        else # needs escaping
          %{"#{m}"}
        end
      end
      candidates = candidates.grep(meth)
      candidates.map{|s| pre + s }
    rescue Exception
      candidates = []
    end
  when /([A-Z]\w+)#(\w*)/ #}
    klass = $1
    meth = $2 ? /\A#{Regexp.quote($2)}/ : /./
    candidates = eval("#{klass}.instance_methods(false)", bind)
    candidates = candidates.grep(meth)
    candidates.map{|s| "'" + klass + '#' + s + "'"}
  else
    IRB::InputCompletor::CompletionProc.call(input)
  end
}
#Readline.basic_word_break_characters= " \t\n\"\\'`><=;|&{("
Readline.basic_word_break_characters= " \t\n\\><=;|&"
Readline.completion_proc = RICompletionProc

####
