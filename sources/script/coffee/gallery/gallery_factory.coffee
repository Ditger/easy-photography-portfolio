###
    Dependencies
###
$ = require( 'jQuery' )
Hooks = require( 'wp_hooks' )
galery_item_data = require( './gallery_item_factory' )



parse_gallery_item = ( key, el ) ->
	$el = $( el )

	index  : key
	data   : galery_item_data( $el )
	caption: $el.find( '.PP_Gallery__caption' ).html( ) || ''


module.exports = ( Gallery_Driver ) ->
	instance = false

	open: ( el ) ->
		$el = $( el )
		$items = $el.closest( '.PP_Gallery' ).find( '.PP_Gallery__item' )

		if $items.length > 0
			index = $items.index( $el )
			gallery_items = $.makeArray( $items.map( parse_gallery_item ) )

			instance = Gallery_Driver( $el )
			instance.open( gallery_items, index )

	close: ->
		return false if not instance

		instance.close( )
		instance = false