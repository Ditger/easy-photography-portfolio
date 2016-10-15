###
    Dependencies
###
$ = require( 'jQuery' )
Hooks = require( "wp_hooks" )
Portfolio_Actions = require( './../class/Abstract_Portfolio_Actions' )


class Portfolio_Masonry extends Portfolio_Actions

	Elements:
		container: 'PP_Masonry'
		sizer    : 'PP_Masonry__sizer'
		item     : 'PP_Masonry__item'

	###
		Initialize
	###
	initialize: ( $parent ) ->
		@$container = $parent.find( ".#{@Elements.container}" )

	###
		Prepare & Attach Events
    	Don't show anything yet.
	###
	prepare: =>
		return if @$container.length is 0

		@$container.addClass( 'PP_JS__loading_masonry' )

		@maybe_create_sizer()
		Hooks.doAction 'pp.masonry.start/before'


		# Only initialize, if no masonry exists
		masonry_settings = Hooks.applyFilters 'pp.masonry.settings',
			itemSelector: ".#{@Elements.item}"
			columnWidth : ".#{@Elements.sizer}"
			gutter      : 0
			initLayout  : false

		@$container.masonry( masonry_settings )

		@$container.masonry 'on', 'layoutComplete', =>
			Hooks.doAction 'pp.masonry.start/complete'
			@$container
			.removeClass( 'PP_JS__loading_masonry' )
			.addClass( 'PP_JS__loading_complete' )


	###
		Start the Portfolio
	###
	create: =>
		@$container.masonry()
		Hooks.doAction 'pp.masonry.start/layout'

		return


	###
		Destroy
	###
	destroy: =>
		@maybe_remove_sizer()

		if @$container.length > 0
			@$container.masonry( 'destroy' )


		return


	###
		Reload the layout
	###
	refresh: =>
		@$container.maosnry( 'layout' )



	###

		Create a sizer element for jquery-masonry to use

	###
	maybe_create_sizer: ->
		@create_sizer() if @sizer_doesnt_exist()
		return

	maybe_remove_sizer: ->
		return if @$container.length isnt 1
		@$container.find( ".#{@Elements.sizer}" ).remove()
		return

	sizer_doesnt_exist: -> @$container.find( ".#{@Elements.sizer}" ).length is 0


	create_sizer: ->
		@$container.append """<div class="#{@Elements.sizer}"></div>"""

		return


module.exports = Portfolio_Masonry