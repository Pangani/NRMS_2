class ChildSearchTerm
	attr_reader :where_clause, :where_args, :order

	def initialize(search_term)
		search_term = search_term.downcase

		@where_clause = ""
		@where_args = {}

		if search_term =~ //
			# Check if search term contain the "@" sign
			# if found, search in email column
			build_for_email_search(search_term)
		else
			# if "@" sign is not available, search in first_name or last_name column
			build_for_name_search(search_term)
		end
	end

private
	# ========== Search in first_name and last_name column
	def build_for_name_search(search_term)
		@where_clause << case_insensitive_search(:first_name)
		@where_args[:first_name] = starts_with(search_term)

		@where_clause << ' OR #{case_insensitive_search(:last_name)}'
		@where_args[:last_name] = starts_with(search_term)

		@order = "last_name asc"
	end

	# ========== Search in all columns
	def extract_name(email)
		# Uses regular expressions to remove everything after the "@ as well as any digits"
		email.gsub(/@.*$/,'').gsub(/[0-9]+/,'')
	end

	def build_for_email_search(search_term)
		@where_clause << case_insensitive_search(:first_name)
		@where_args[:first_name] = starts_with(extract_name(search_term))

		@where_clause << " OR #{case_insensitive_search(:last_name)}"
		@where_args[:last_name] = starts_with(extract_name(search_term))

		@where_clause << " OR #{case_insensitive_search(:reg_number)}"
		@where_args[:reg_number] = search_term

		@order = "lower(reg_number) = " + ActiveRecord::Base.connection.quote(search_term) + " desc, last_name asc"
	end

# =-------------------------------------------------------------------------------------
	def starts_with(search_term)
		# this helper method takes a part of a string entered
		search_term + '%'
	end

	def case_insensitive_search(field_name)
		# constructs the SQL fragment
		"lower(#{field_name}) like :#{field_name}"
	end
end