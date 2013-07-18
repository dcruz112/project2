require 'net/ldap'

class User < ActiveRecord::Base
	has_many :posts
	has_many :votes
	has_many :flags
	has_many :comment

	def full_name
		first_name + " " + last_name
	end

	def search_ldap(login)
	    ldap = Net::LDAP.new(host: "directory.yale.edu", port: 389)
	    filter = Net::LDAP::Filter.eq("uid", login)
	    attrs = ["givenname", "sn", "eduPersonNickname", "telephoneNumber", "uid",
	             "mail", "collegename", "curriculumshortname", "college", "class"]
	    result = ldap.search(base: "ou=People,o=yale.edu", filter: filter, attributes: attrs)
		if !result.empty?
			fname  = result[0][:givenname][0]
			self.first_name = fname
			self.last_name   = result[0][:sn][0]
	    	@nickname = result[0][:eduPersonNickname]
			if !@nickname.empty?
			    self.first_name  = @nickname[0]
			end
			self.email   = result[0][:mail][0]
			self.class_year = result[0][:class][0]
		end
	end

end
