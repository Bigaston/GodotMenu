# Menu

This is a Godot Addon to manage beaufifull (no) Menu Flow.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/A0A05WS6)

## Installation
Use [git subrepo](https://github.com/ingydotnet/git-subrepo) to install me!  (To install Git Subrepo [watch this](https://codeberg.org/Bigaston/GodotAddons/src/branch/main/subrepo.md))  

```sh
git subrepo clone git@codeberg.org:Bigaston/GodotLogger.git addons/me.bigaston.menu
```

Then, you can use `git subrepo pull addons/me.bigaston.menu` and `git subrepo pull addons/me.bigaston.menu`

## Types
### MenuManager
The menu manager contains different [MenuPage](#MenuPage) and can manage connection between them and transition.

#### Attributes
**default_page** *(MenuPage)*: The default displayed page of this MenuManager, if not set, take the first one
**flow_event** *(name: StringName, destination: MenuPage)*: Link of PageFlowEvents and their respective destination. If a *flow_event* signal with this name is sended by a page, go the the destination

### MenuPage
The differents pages of the MenuManager. Must be a child of MenuManager

#### Signals
**flow_event** *(event_name: StringName)*: Sended by the MenuButtonFlow, but can be used to send to MenuManager some page change request

#### Attributes
**timeline** *(AnimationPlayer)*: An AnimationPlayer that can be use as transition manager. Can include **enter** and **exit** animation, launched by MenuManager
**default_control** *(Control)*: The default control that needs to be focussed at the start
**button_flow** *(button: Button, event_name: StringName)*: Send auto **flow_event** when this button is pressed
