" Vim syntax file
" Language: C at-spi extension (for version unknown)
" Maintainer: David Nečas (Yeti) <yeti@physics.muni.cz>
" Last Change: 2012-10-15
" URL: http://physics.muni.cz/~yeti/vim/gtk-syntax.tar.gz
" Generated By: vim-syn-gen.py

syn keyword atspiFunction atspi_accessible_clear_cache atspi_accessible_get_action atspi_accessible_get_application atspi_accessible_get_atspi_version atspi_accessible_get_attributes atspi_accessible_get_attributes_as_array atspi_accessible_get_child_at_index atspi_accessible_get_child_count atspi_accessible_get_collection atspi_accessible_get_component atspi_accessible_get_description atspi_accessible_get_document atspi_accessible_get_editable_text atspi_accessible_get_hyperlink atspi_accessible_get_hypertext atspi_accessible_get_id atspi_accessible_get_image atspi_accessible_get_index_in_parent atspi_accessible_get_interfaces atspi_accessible_get_localized_role_name atspi_accessible_get_name atspi_accessible_get_parent atspi_accessible_get_process_id atspi_accessible_get_relation_set atspi_accessible_get_role atspi_accessible_get_role_name atspi_accessible_get_selection atspi_accessible_get_state_set atspi_accessible_get_table atspi_accessible_get_text atspi_accessible_get_toolkit_name atspi_accessible_get_toolkit_version atspi_accessible_get_type atspi_accessible_get_value atspi_accessible_set_cache_mask atspi_action_do_action atspi_action_get_description atspi_action_get_key_binding atspi_action_get_localized_name atspi_action_get_n_actions atspi_action_get_name atspi_action_get_type atspi_collection_get_active_descendant atspi_collection_get_matches atspi_collection_get_matches_from atspi_collection_get_matches_to atspi_collection_get_type atspi_collection_is_ancestor_of atspi_component_contains atspi_component_get_accessible_at_point atspi_component_get_alpha atspi_component_get_extents atspi_component_get_layer atspi_component_get_mdi_z_order atspi_component_get_position atspi_component_get_size atspi_component_get_type atspi_component_grab_focus atspi_component_set_extents atspi_component_set_position atspi_component_set_size atspi_dbus_connection_setup_with_g_main atspi_dbus_server_setup_with_g_main atspi_deregister_device_event_listener atspi_deregister_keystroke_listener atspi_device_listener_add_callback atspi_device_listener_get_type atspi_device_listener_new atspi_device_listener_new_simple atspi_device_listener_remove_callback atspi_document_get_attribute_value atspi_document_get_attributes atspi_document_get_locale atspi_document_get_type atspi_editable_text_copy_text atspi_editable_text_cut_text atspi_editable_text_delete_text atspi_editable_text_get_type atspi_editable_text_insert_text atspi_editable_text_paste_text atspi_editable_text_set_attributes atspi_event_get_type atspi_event_listener_deregister atspi_event_listener_deregister_from_callback atspi_event_listener_deregister_no_data atspi_event_listener_get_type atspi_event_listener_new atspi_event_listener_new_simple atspi_event_listener_register atspi_event_listener_register_from_callback atspi_event_listener_register_no_data atspi_event_main atspi_event_quit atspi_exit atspi_generate_keyboard_event atspi_generate_mouse_event atspi_get_a11y_bus atspi_get_desktop atspi_get_desktop_count atspi_get_desktop_list atspi_hyperlink_get_end_index atspi_hyperlink_get_index_range atspi_hyperlink_get_n_anchors atspi_hyperlink_get_object atspi_hyperlink_get_start_index atspi_hyperlink_get_type atspi_hyperlink_get_uri atspi_hyperlink_is_valid atspi_hypertext_get_link atspi_hypertext_get_link_index atspi_hypertext_get_n_links atspi_hypertext_get_type atspi_image_get_image_description atspi_image_get_image_extents atspi_image_get_image_locale atspi_image_get_image_position atspi_image_get_image_size atspi_image_get_type atspi_init atspi_key_definition_get_type atspi_match_rule_get_type atspi_match_rule_new atspi_object_get_type atspi_point_copy atspi_point_get_type atspi_range_copy atspi_range_get_type atspi_rect_copy atspi_rect_get_type atspi_register_device_event_listener atspi_register_keystroke_listener atspi_relation_get_n_targets atspi_relation_get_relation_type atspi_relation_get_target atspi_relation_get_type atspi_role_get_name atspi_selection_clear_selection atspi_selection_deselect_child atspi_selection_deselect_selected_child atspi_selection_get_n_selected_children atspi_selection_get_selected_child atspi_selection_get_type atspi_selection_is_child_selected atspi_selection_select_all atspi_selection_select_child atspi_set_timeout atspi_state_set_add atspi_state_set_compare atspi_state_set_contains atspi_state_set_equals atspi_state_set_get_states atspi_state_set_get_type atspi_state_set_is_empty atspi_state_set_new atspi_state_set_remove atspi_state_set_set_by_name atspi_table_add_column_selection atspi_table_add_row_selection atspi_table_get_accessible_at atspi_table_get_caption atspi_table_get_column_at_index atspi_table_get_column_description atspi_table_get_column_extent_at atspi_table_get_column_header atspi_table_get_index_at atspi_table_get_n_columns atspi_table_get_n_rows atspi_table_get_n_selected_columns atspi_table_get_n_selected_rows atspi_table_get_row_at_index atspi_table_get_row_column_extents_at_index atspi_table_get_row_description atspi_table_get_row_extent_at atspi_table_get_row_header atspi_table_get_selected_columns atspi_table_get_selected_rows atspi_table_get_summary atspi_table_get_type atspi_table_is_column_selected atspi_table_is_row_selected atspi_table_is_selected atspi_table_remove_column_selection atspi_table_remove_row_selection atspi_text_add_selection atspi_text_get_attribute_run atspi_text_get_attribute_value atspi_text_get_attributes atspi_text_get_bounded_ranges atspi_text_get_caret_offset atspi_text_get_character_at_offset atspi_text_get_character_count atspi_text_get_character_extents atspi_text_get_default_attributes atspi_text_get_n_selections atspi_text_get_offset_at_point atspi_text_get_range_extents atspi_text_get_selection atspi_text_get_text atspi_text_get_text_after_offset atspi_text_get_text_at_offset atspi_text_get_text_before_offset atspi_text_get_type atspi_text_range_get_type atspi_text_remove_selection atspi_text_set_caret_offset atspi_text_set_selection atspi_value_get_current_value atspi_value_get_maximum_value atspi_value_get_minimum_increment atspi_value_get_minimum_value atspi_value_get_type atspi_value_set_current_value
syn keyword atspiTypedef AtspiControllerEventMask AtspiDeviceEventMask AtspiKeyEventMask AtspiKeyMaskType AtspiKeystrokeListener
syn keyword atspiConstant ATSPI_BUTTON_PRESSED_EVENT ATSPI_BUTTON_RELEASED_EVENT ATSPI_CACHE_ALL ATSPI_CACHE_ATTRIBUTES ATSPI_CACHE_CHILDREN ATSPI_CACHE_DEFAULT ATSPI_CACHE_DESCRIPTION ATSPI_CACHE_INTERFACES ATSPI_CACHE_NAME ATSPI_CACHE_NONE ATSPI_CACHE_PARENT ATSPI_CACHE_ROLE ATSPI_CACHE_STATES ATSPI_CACHE_UNDEFINED ATSPI_COORD_TYPE_SCREEN ATSPI_COORD_TYPE_WINDOW ATSPI_ERROR_APPLICATION_GONE ATSPI_ERROR_IPC ATSPI_KEYLISTENER_ALL_WINDOWS ATSPI_KEYLISTENER_CANCONSUME ATSPI_KEYLISTENER_NOSYNC ATSPI_KEYLISTENER_SYNCHRONOUS ATSPI_KEY_PRESS ATSPI_KEY_PRESSED ATSPI_KEY_PRESSED_EVENT ATSPI_KEY_PRESSRELEASE ATSPI_KEY_RELEASE ATSPI_KEY_RELEASED ATSPI_KEY_RELEASED_EVENT ATSPI_KEY_STRING ATSPI_KEY_SYM ATSPI_LAYER_BACKGROUND ATSPI_LAYER_CANVAS ATSPI_LAYER_INVALID ATSPI_LAYER_LAST_DEFINED ATSPI_LAYER_MDI ATSPI_LAYER_OVERLAY ATSPI_LAYER_POPUP ATSPI_LAYER_WIDGET ATSPI_LAYER_WINDOW ATSPI_LOCALE_TYPE_COLLATE ATSPI_LOCALE_TYPE_CTYPE ATSPI_LOCALE_TYPE_MESSAGES ATSPI_LOCALE_TYPE_MONETARY ATSPI_LOCALE_TYPE_NUMERIC ATSPI_LOCALE_TYPE_TIME ATSPI_MODIFIER_ALT ATSPI_MODIFIER_CONTROL ATSPI_MODIFIER_META ATSPI_MODIFIER_META2 ATSPI_MODIFIER_META3 ATSPI_MODIFIER_NUMLOCK ATSPI_MODIFIER_SHIFT ATSPI_MODIFIER_SHIFTLOCK ATSPI_RELATION_CONTROLLED_BY ATSPI_RELATION_CONTROLLER_FOR ATSPI_RELATION_DESCRIBED_BY ATSPI_RELATION_DESCRIPTION_FOR ATSPI_RELATION_EMBEDDED_BY ATSPI_RELATION_EMBEDS ATSPI_RELATION_EXTENDED ATSPI_RELATION_FLOWS_FROM ATSPI_RELATION_FLOWS_TO ATSPI_RELATION_LABELLED_BY ATSPI_RELATION_LABEL_FOR ATSPI_RELATION_LAST_DEFINED ATSPI_RELATION_MEMBER_OF ATSPI_RELATION_NODE_CHILD_OF ATSPI_RELATION_NODE_PARENT_OF ATSPI_RELATION_NULL ATSPI_RELATION_PARENT_WINDOW_OF ATSPI_RELATION_POPUP_FOR ATSPI_RELATION_SUBWINDOW_OF ATSPI_RELATION_TOOLTIP_FOR ATSPI_ROLE_ACCELERATOR_LABEL ATSPI_ROLE_ALERT ATSPI_ROLE_ANIMATION ATSPI_ROLE_APPLICATION ATSPI_ROLE_ARROW ATSPI_ROLE_AUTOCOMPLETE ATSPI_ROLE_CALENDAR ATSPI_ROLE_CANVAS ATSPI_ROLE_CAPTION ATSPI_ROLE_CHART ATSPI_ROLE_CHECK_BOX ATSPI_ROLE_CHECK_MENU_ITEM ATSPI_ROLE_COLOR_CHOOSER ATSPI_ROLE_COLUMN_HEADER ATSPI_ROLE_COMBO_BOX ATSPI_ROLE_COMMENT ATSPI_ROLE_DATE_EDITOR ATSPI_ROLE_DESKTOP_FRAME ATSPI_ROLE_DESKTOP_ICON ATSPI_ROLE_DIAL ATSPI_ROLE_DIALOG ATSPI_ROLE_DIRECTORY_PANE ATSPI_ROLE_DOCUMENT_EMAIL ATSPI_ROLE_DOCUMENT_FRAME ATSPI_ROLE_DOCUMENT_PRESENTATION ATSPI_ROLE_DOCUMENT_SPREADSHEET ATSPI_ROLE_DOCUMENT_TEXT ATSPI_ROLE_DOCUMENT_WEB ATSPI_ROLE_DRAWING_AREA ATSPI_ROLE_EDITBAR ATSPI_ROLE_EMBEDDED ATSPI_ROLE_ENTRY ATSPI_ROLE_EXTENDED ATSPI_ROLE_FILE_CHOOSER ATSPI_ROLE_FILLER ATSPI_ROLE_FOCUS_TRAVERSABLE ATSPI_ROLE_FONT_CHOOSER ATSPI_ROLE_FOOTER ATSPI_ROLE_FORM ATSPI_ROLE_FRAME ATSPI_ROLE_GLASS_PANE ATSPI_ROLE_GROUPING ATSPI_ROLE_HEADER ATSPI_ROLE_HEADING ATSPI_ROLE_HTML_CONTAINER ATSPI_ROLE_ICON ATSPI_ROLE_IMAGE ATSPI_ROLE_IMAGE_MAP ATSPI_ROLE_INFO_BAR ATSPI_ROLE_INPUT_METHOD_WINDOW ATSPI_ROLE_INTERNAL_FRAME ATSPI_ROLE_INVALID ATSPI_ROLE_LABEL ATSPI_ROLE_LAST_DEFINED ATSPI_ROLE_LAYERED_PANE ATSPI_ROLE_LINK ATSPI_ROLE_LIST ATSPI_ROLE_LIST_BOX ATSPI_ROLE_LIST_ITEM ATSPI_ROLE_MENU ATSPI_ROLE_MENU_BAR ATSPI_ROLE_MENU_ITEM ATSPI_ROLE_NOTIFICATION ATSPI_ROLE_OPTION_PANE ATSPI_ROLE_PAGE ATSPI_ROLE_PAGE_TAB ATSPI_ROLE_PAGE_TAB_LIST ATSPI_ROLE_PANEL ATSPI_ROLE_PARAGRAPH ATSPI_ROLE_PASSWORD_TEXT ATSPI_ROLE_POPUP_MENU ATSPI_ROLE_PROGRESS_BAR ATSPI_ROLE_PUSH_BUTTON ATSPI_ROLE_RADIO_BUTTON ATSPI_ROLE_RADIO_MENU_ITEM ATSPI_ROLE_REDUNDANT_OBJECT ATSPI_ROLE_ROOT_PANE ATSPI_ROLE_ROW_HEADER ATSPI_ROLE_RULER ATSPI_ROLE_SCROLL_BAR ATSPI_ROLE_SCROLL_PANE ATSPI_ROLE_SECTION ATSPI_ROLE_SEPARATOR ATSPI_ROLE_SLIDER ATSPI_ROLE_SPIN_BUTTON ATSPI_ROLE_SPLIT_PANE ATSPI_ROLE_STATUS_BAR ATSPI_ROLE_TABLE ATSPI_ROLE_TABLE_CELL ATSPI_ROLE_TABLE_COLUMN_HEADER ATSPI_ROLE_TABLE_ROW ATSPI_ROLE_TABLE_ROW_HEADER ATSPI_ROLE_TEAROFF_MENU_ITEM ATSPI_ROLE_TERMINAL ATSPI_ROLE_TEXT ATSPI_ROLE_TOGGLE_BUTTON ATSPI_ROLE_TOOL_BAR ATSPI_ROLE_TOOL_TIP ATSPI_ROLE_TREE ATSPI_ROLE_TREE_ITEM ATSPI_ROLE_TREE_TABLE ATSPI_ROLE_UNKNOWN ATSPI_ROLE_VIEWPORT ATSPI_ROLE_WINDOW ATSPI_STATE_ACTIVE ATSPI_STATE_ANIMATED ATSPI_STATE_ARMED ATSPI_STATE_BUSY ATSPI_STATE_CHECKED ATSPI_STATE_COLLAPSED ATSPI_STATE_DEFUNCT ATSPI_STATE_EDITABLE ATSPI_STATE_ENABLED ATSPI_STATE_EXPANDABLE ATSPI_STATE_EXPANDED ATSPI_STATE_FOCUSABLE ATSPI_STATE_FOCUSED ATSPI_STATE_HAS_TOOLTIP ATSPI_STATE_HORIZONTAL ATSPI_STATE_ICONIFIED ATSPI_STATE_INDETERMINATE ATSPI_STATE_INVALID ATSPI_STATE_INVALID_ENTRY ATSPI_STATE_IS_DEFAULT ATSPI_STATE_LAST_DEFINED ATSPI_STATE_MANAGES_DESCENDANTS ATSPI_STATE_MODAL ATSPI_STATE_MULTISELECTABLE ATSPI_STATE_MULTI_LINE ATSPI_STATE_OPAQUE ATSPI_STATE_PRESSED ATSPI_STATE_REQUIRED ATSPI_STATE_RESIZABLE ATSPI_STATE_SELECTABLE ATSPI_STATE_SELECTABLE_TEXT ATSPI_STATE_SELECTED ATSPI_STATE_SENSITIVE ATSPI_STATE_SHOWING ATSPI_STATE_SINGLE_LINE ATSPI_STATE_STALE ATSPI_STATE_SUPPORTS_AUTOCOMPLETION ATSPI_STATE_TRANSIENT ATSPI_STATE_TRUNCATED ATSPI_STATE_VERTICAL ATSPI_STATE_VISIBLE ATSPI_STATE_VISITED ATSPI_TEXT_BOUNDARY_CHAR ATSPI_TEXT_BOUNDARY_LINE_END ATSPI_TEXT_BOUNDARY_LINE_START ATSPI_TEXT_BOUNDARY_SENTENCE_END ATSPI_TEXT_BOUNDARY_SENTENCE_START ATSPI_TEXT_BOUNDARY_WORD_END ATSPI_TEXT_BOUNDARY_WORD_START ATSPI_TEXT_CLIP_BOTH ATSPI_TEXT_CLIP_MAX ATSPI_TEXT_CLIP_MIN ATSPI_TEXT_CLIP_NONE
syn keyword atspiStruct AtspiAccessible AtspiAccessibleClass AtspiAction AtspiApplication AtspiApplicationClass AtspiCollection AtspiComponent AtspiDeviceEvent AtspiDeviceListener AtspiDeviceListenerClass AtspiDocument AtspiEditableText AtspiEvent AtspiEventListener AtspiEventListenerClass AtspiEventListenerMode AtspiHyperlink AtspiHyperlinkClass AtspiHypertext AtspiImage AtspiKeyDefinition AtspiMatchRule AtspiMatchRuleClass AtspiObject AtspiObjectClass AtspiPoint AtspiRange AtspiRect AtspiReference AtspiRelation AtspiRelationClass AtspiSelection AtspiStateSet AtspiStateSetClass AtspiTable AtspiText AtspiTextRange AtspiValue
syn keyword atspiMacro ATSPI_ACCESSIBLE ATSPI_ACCESSIBLE_CLASS ATSPI_ACCESSIBLE_GET_CLASS ATSPI_ACTION ATSPI_ACTION_GET_IFACE ATSPI_APPLICATION ATSPI_APPLICATION_CLASS ATSPI_APPLICATION_GET_CLASS ATSPI_COLLECTION ATSPI_COLLECTION_GET_IFACE ATSPI_COMPONENT ATSPI_COMPONENT_GET_IFACE ATSPI_DEVICE_LISTENER ATSPI_DEVICE_LISTENER_CLASS ATSPI_DEVICE_LISTENER_GET_CLASS ATSPI_DOCUMENT ATSPI_DOCUMENT_GET_IFACE ATSPI_EDITABLE_TEXT ATSPI_EDITABLE_TEXT_GET_IFACE ATSPI_EVENT_LISTENER ATSPI_EVENT_LISTENER_CLASS ATSPI_EVENT_LISTENER_GET_CLASS ATSPI_HYPERLINK ATSPI_HYPERLINK_CLASS ATSPI_HYPERLINK_GET_CLASS ATSPI_HYPERTEXT ATSPI_HYPERTEXT_GET_IFACE ATSPI_IMAGE ATSPI_IMAGE_GET_IFACE ATSPI_IS_ACCESSIBLE ATSPI_IS_ACCESSIBLE_CLASS ATSPI_IS_ACTION ATSPI_IS_APPLICATION ATSPI_IS_APPLICATION_CLASS ATSPI_IS_COLLECTION ATSPI_IS_COMPONENT ATSPI_IS_DEVICE_LISTENER ATSPI_IS_DEVICE_LISTENER_CLASS ATSPI_IS_DOCUMENT ATSPI_IS_EDITABLE_TEXT ATSPI_IS_EVENT_LISTENER ATSPI_IS_EVENT_LISTENER_CLASS ATSPI_IS_HYPERLINK ATSPI_IS_HYPERLINK_CLASS ATSPI_IS_HYPERTEXT ATSPI_IS_IMAGE ATSPI_IS_MATCH_RULE ATSPI_IS_MATCH_RULE_CLASS ATSPI_IS_OBJECT ATSPI_IS_OBJECT_CLASS ATSPI_IS_RELATION ATSPI_IS_SELECTION ATSPI_IS_STATE_SET ATSPI_IS_STATE_SET_CLASS ATSPI_IS_TABLE ATSPI_IS_TEXT ATSPI_IS_VALUE ATSPI_MATCH_RULE ATSPI_MATCH_RULE_CLASS ATSPI_MATCH_RULE_GET_CLASS ATSPI_OBJECT ATSPI_OBJECT_CLASS ATSPI_OBJECT_GET_CLASS ATSPI_RELATION ATSPI_RELATION_GET_IFACE ATSPI_SELECTION ATSPI_SELECTION_GET_IFACE ATSPI_STATE_SET ATSPI_STATE_SET_CLASS ATSPI_STATE_SET_GET_CLASS ATSPI_TABLE ATSPI_TABLE_GET_IFACE ATSPI_TEXT ATSPI_TEXT_GET_IFACE ATSPI_VALUE ATSPI_VALUE_GET_IFACE
syn keyword atspiEnum AtspiCache AtspiCollectionMatchType AtspiCollectionSortOrder AtspiCollectionTreeTraversalType AtspiComponentLayer AtspiCoordType AtspiError AtspiEventType AtspiKeyEventType AtspiKeyListenerSyncType AtspiKeySynthType AtspiLocaleType AtspiModifierType AtspiRelationType AtspiRole AtspiStateType AtspiTextBoundaryType AtspiTextClipType
syn keyword atspiVariable atspi_bus_registry atspi_interface_accessible atspi_interface_action atspi_interface_application atspi_interface_cache atspi_interface_collection atspi_interface_component atspi_interface_dec atspi_interface_device_event_listener atspi_interface_document atspi_interface_editable_text atspi_interface_hyperlink atspi_interface_hypertext atspi_interface_image atspi_interface_registry atspi_interface_selection atspi_interface_table atspi_interface_text atspi_interface_value atspi_main_loop atspi_no_cache atspi_path_dec atspi_path_registry atspi_path_root
syn keyword atspiUserFunction AtspiDeviceListenerCB AtspiDeviceListenerSimpleCB AtspiEventListenerCB AtspiEventListenerSimpleCB
syn keyword atspiDefine ATSPI_COMPONENTLAYER_COUNT ATSPI_COORD_TYPE_COUNT ATSPI_DBUS_INTERFACE_ACCESSIBLE ATSPI_DBUS_INTERFACE_ACTION ATSPI_DBUS_INTERFACE_APPLICATION ATSPI_DBUS_INTERFACE_CACHE ATSPI_DBUS_INTERFACE_COLLECTION ATSPI_DBUS_INTERFACE_COMPONENT ATSPI_DBUS_INTERFACE_DEC ATSPI_DBUS_INTERFACE_DEVICE_EVENT_LISTENER ATSPI_DBUS_INTERFACE_DOCUMENT ATSPI_DBUS_INTERFACE_EDITABLE_TEXT ATSPI_DBUS_INTERFACE_EVENT_KEYBOARD ATSPI_DBUS_INTERFACE_EVENT_MOUSE ATSPI_DBUS_INTERFACE_EVENT_OBJECT ATSPI_DBUS_INTERFACE_HYPERLINK ATSPI_DBUS_INTERFACE_HYPERTEXT ATSPI_DBUS_INTERFACE_IMAGE ATSPI_DBUS_INTERFACE_REGISTRY ATSPI_DBUS_INTERFACE_SELECTION ATSPI_DBUS_INTERFACE_SOCKET ATSPI_DBUS_INTERFACE_TABLE ATSPI_DBUS_INTERFACE_TEXT ATSPI_DBUS_INTERFACE_VALUE ATSPI_DBUS_NAME_REGISTRY ATSPI_DBUS_PATH_DEC ATSPI_DBUS_PATH_NULL ATSPI_DBUS_PATH_REGISTRY ATSPI_DBUS_PATH_ROOT ATSPI_ERROR ATSPI_EVENTTYPE_COUNT ATSPI_KEYEVENTTYPE_COUNT ATSPI_KEYSYNTHTYPE_COUNT ATSPI_LOCALE_TYPE ATSPI_MATCHTYPES_COUNT ATSPI_MODIFIERTYPE_COUNT ATSPI_RELATIONTYPE_COUNT ATSPI_ROLE_COUNT ATSPI_SORTORDER_COUNT ATSPI_STATETYPE_COUNT ATSPI_TEXT_BOUNDARY_TYPE_COUNT ATSPI_TEXT_CLIP_TYPE_COUNT ATSPI_TREETRAVERSALTYPE ATSPI_TYPE_ACCESSIBLE ATSPI_TYPE_ACTION ATSPI_TYPE_APPLICATION ATSPI_TYPE_COLLECTION ATSPI_TYPE_COMPONENT ATSPI_TYPE_DEVICE_LISTENER ATSPI_TYPE_DOCUMENT ATSPI_TYPE_EDITABLE_TEXT ATSPI_TYPE_EVENT ATSPI_TYPE_EVENT_LISTENER ATSPI_TYPE_HYPERLINK ATSPI_TYPE_HYPERTEXT ATSPI_TYPE_IMAGE ATSPI_TYPE_MATCH_RULE ATSPI_TYPE_OBJECT ATSPI_TYPE_POINT ATSPI_TYPE_RANGE ATSPI_TYPE_RECT ATSPI_TYPE_RELATION ATSPI_TYPE_SELECTION ATSPI_TYPE_STATE_SET ATSPI_TYPE_TABLE ATSPI_TYPE_TEXT ATSPI_TYPE_TEXT_RANGE ATSPI_TYPE_VALUE

" Default highlighting
if version >= 508 || !exists("did_atspi_syntax_inits")
  if version < 508
    let did_atspi_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink atspiFunction Function
  HiLink atspiTypedef Type
  HiLink atspiConstant Constant
  HiLink atspiStruct Type
  HiLink atspiMacro Macro
  HiLink atspiEnum Type
  HiLink atspiVariable Identifier
  HiLink atspiUserFunction Type
  HiLink atspiDefine Constant

  delcommand HiLink
endif

