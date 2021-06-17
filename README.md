## What is this?

This is a Plasmoid, i.e. a desktop widget,
that **shows the window titles with the longest associated non-AFK duration of the day**.

It's a really early prototype.
Using some [Voodoo programming](https://en.wikipedia.org/wiki/Voodoo_programming),
I got it to a usable state.

License: TBD. For now, feel free to hack around an submit PRs.

## Development

Some useful commands:

`plasmawindowed activitywatch-plasmoid/plasmoid` (does not work anymore?)

`kpackagetool5 -t Plasma/Applet --install plasmoid`
`kpackagetool5 -t Plasma/Applet --upgrade plasmoid`
`kpackagetool5 -t Plasma/Applet --remove de.nicolaiweitkemper.activitywatch`

## Sources

-   <https://techbase.kde.org/Development/Tutorials/Plasma5/QML2/GettingStarted>
