# FluentGDIContextMenu
Fluent-GDI-ContextMenu

Matches Conext Menu Fluent settings
Caviat:
Depends on current context menu theme resource, ie. #

The context menu texture is transparent  

This will not work on unmodified textures supplied in Aero theme

Will require patched UXtheme.dll and 3rd party MSStyles. I have included an example MSSTYLES and UXTHEME. 

The Location on Ave Style Build:
Windows 10 Dark Mode > Lists, Menus, & Tabs > Context Menu > PopUpBackground
Or in Msstyles
Darkmode::menu<menu>.popupbackgroundpopupbackground<default>
  
xtended Features
I have made a dll in C++ which when injected will detect and add icons for a multitude of menu entries.

Icons must be in BMP format no larger than 24 x 24 in the folder c:\icon\24\  (20 is better)

the Systray main menu has added entries for settings to toggle features


disable entries on context such as Restore previous versions
Enable "paste currently playing file in Win Media Player" entry
open containing folder entry
