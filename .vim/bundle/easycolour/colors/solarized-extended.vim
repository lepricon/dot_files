" Vim Colour Scheme based on EasyColour Plugin

hi clear
if exists("syntax_on")
	syntax reset
endif

call EasyColour#ColourScheme#LoadColourScheme('solarized-extended')
