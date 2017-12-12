$ = require( 'jQuery' )
Hooks = require( 'wp_hooks' )


instance = false

destroy = ->
	return if not instance
	instance.destroy( )
	instance = null

create = ->

	# Make sure an instance doesn't already exist
	destroy( )

	# Handler required
	Handler = Hooks.applyFilters 'phort.lazy.handler', require( './Lazy_Default' )
	return if not Handler

	# By default Lazy_Masonry is handling Lazy-Loading
	# Check if anyone wants to hijack handler
	instance = new Handler( )

	return


# Initialize lazy loader after the portfolio is prepared, p = 100
Hooks.addAction 'phort.portfolio.prepare', create, 100
Hooks.addAction 'phort.portfolio.destroy', destroy

module.exports =
	create : create
	destroy: destroy