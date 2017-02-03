module ForwardableExtension

	def delegate_to(object, *args)
		options = args.last.is_a?(Hash) ? args.pop : {}
		args.each do |element|
			def_delegator object, element, name_with_prefix(element, options).to_sym
			if options[:writer]
				def_delegator object, :"#{element}=", :"#{name_with_prefix(element, options)}="
			end
		end
	end

	protected
	def name_with_prefix(element, options)
		"#{options[:prefix] + "_" unless options[:prefix].nil? }#{element}"
	end

	Forwardable.send :include, ForwardableExtension
end