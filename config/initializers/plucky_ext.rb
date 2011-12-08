Plucky::Query.class_eval do
  alias_method :find_old, :find
  def find_new(*args)
     options = args.extract_options!
     first = args.shift
     args.push(options)
     
     case first
        when :first
          first(*args)
        when :last
          last(*args)
        when :all
          all(*args)
        else
          args.unshift(first) unless first.nil?
          find_old(*args)
     end
  end
  alias_method :find, :find_new
end