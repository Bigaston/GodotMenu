# Menu

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