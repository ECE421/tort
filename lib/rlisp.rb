# Credit for RLisp to https://github.com/fogus/ulithp/blob/master/src/lithp.rb

class RLisp
    def initialize()
        @context = { 
            :label => proc { |(name,val)| @context[name] = eval(val, @context) },
            :car   => lambda { |(list), _| list.first },
            :cdr   => lambda { |(list), _| list.drop 1 },
            :cons  => lambda { |(e,cell), _| [e] + cell },
            :eq    => lambda { |(l,r), ctx| eval(l, ctx) == eval(r, ctx) },
            :if    => proc { |(cond, thn, els), ctx| eval(cond, ctx) ? eval(thn, ctx) : eval(els, ctx) },
            :atom  => lambda { |(sexpr), _| (sexpr.is_a? Symbol) or (sexpr.is_a? Numeric) },
            :quote => proc { |sexpr| sexpr[0] } 
        }
    end
  
    def eval sexpr, context=@context
      return context[sexpr] || sexpr if context[:atom].call [sexpr], context
      function, *args = sexpr
      args = args.map { 
          |arg| eval(arg, context) 
        } if context[function].is_a?(Array) || (context[function].respond_to?(:lambda?) && context[function].lambda?)
      return context[function].call(args, context) if context[function].respond_to? :call 
      eval context[function][2], context.merge(Hash[*(context[function][1].zip args).flatten(1)])
    end
  end