## What is this?

This is a Plasmoid, i.e. a desktop widget,
that **shows the window titles with the longest associated non-AFK duration of the day**.

It's a really early prototype.
Using some [Voodoo programming](https://en.wikipedia.org/wiki/Voodoo_programming),
I got it to a usable state.

License: TBD. For now, feel free to hack around an submit PRs.

## Development

Some useful commands:

```shell
# preview the *local* plasmoid
# Note: Click and hold to change the plasmoid's size – at least that's the only way it works for me.
plasmoidviewer -a plasmoid

# preview the *installed* plasmoid
plasmawindowed de.nicolaiweitkemper.activitywatch


# install; only works if not present
kpackagetool5 -t Plasma/Applet --install plasmoid

# otherwise, use
kpackagetool5 -t Plasma/Applet --upgrade plasmoid

# for uninstalling (untested), use
kpackagetool5 -t Plasma/Applet --remove de.nicolaiweitkemper.activitywatch
```

## Sources

-   <https://techbase.kde.org/Development/Tutorials/Plasma5/QML2/GettingStarted>
-   <https://zren.github.io/kde/docs/widget/>
