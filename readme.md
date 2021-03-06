# Ruby driver for HBase

Small and handy Ruby driver for HBase (via Stargate RESTfull interface).

# Usage

**Warning:** HBase and Stargate should be installed and running.

	require 'hbase'

	hbase = HBase.new('http://localhost:8080')

	# creating table
	hbase.create 'users'

	# listing all tables
	p hbase.all.collect{|t| t.name} # => ['users']

	# create record
	users.update 'john', 'attr:email' => 'john@mail.com'

	# get record
	john = users['john']
	p john['attr:email'] # => "john@mail.com"    

	# update record
	users.update 'john', 'attr:email' => "another@mail.com"
	p john['attr:email'] # => "another@mail.com"

	# deleting record
	users.delete 'john'    

	# scanning
	users.update 'john', 'attr:email' => 'john@mail.com'
	users.update 'mario', 'attr:email' => 'mario@mail.com'
	users.update 'stanley', 'attr:email' => 'stanley@mail.com'

	list = users.scan :start => 'john', :batch => 5, :columns => ['attr:']
	p list.collect{|user| user['attr:email']} # => ['john@mail.com', 'mario@mail.com', 'stanley@mail.com']
	
# Installation

	$ gem install ruby-driver
	
For installation of HBase and Stargate please see HBase docs (google it).

**Warning:** currently HBase distributed with RESTful interface called 'rest' and it's deprecated and broken. And because it looks very similar to Stargate it's easy to mix it up. So, be aware, you need to install and use the Stargate, not default and broken HBase REST client.

# Contributors

- [Alexey Petrushin](http://github.com/alexeypetrushin)
- [Dmitry Larkin](http://github.com/dml)