meta:
  id: lego_universe_packet
  file-extension: bin
  endian: le
seq:
  - id: message_id
    type: u1
    enum: messageid
  - id: connection_id
    type: u2
    enum: connection_type
  - id: data
    type:
      switch-on: connection_id
      cases:
        connection_type::server: server_message
        connection_type::auth: auth_message
        connection_type::chat: chat_message
        connection_type::chat_internal: chat_internal_message
        connection_type::world: world_message
        connection_type::client: client_message
        connection_type::master: master_message

types:
# COMMON
  u4_wstr:
    seq:
      - id: length
        type: u4
      - id: str
        type: str
        size: length * 2
        encoding: utf-16le
  object_id:
    seq:
      - id: object_id
        type: u8
  vector3:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
# IM LAZY
  lu_wstring_33:
   seq:
    - id: message
      type: str
      size: 33 * 2
      encoding: utf-16le
  lu_wstring_512:
   seq:
    - id: message
      type: str
      size: 512 * 2
      encoding: utf-16le

# MAYBE GOOD EXTRAS
  zone_id:
    seq:
      - id: map_id
        type: u2
      - id: instance_id
        type: u2
      - id: clone_id
        type: u4

# CHAT MESSAGES
  chat_message:
    seq:
      - id: chat_packet_id
        type: u4
        enum: chat_packet_type
      - id: header_padding
        type: u1
      - id: sender_id
        type: object_id
      - id: chat_packet_data
        type:
          switch-on: chat_packet_id
          cases:
            chat_packet_type::login_session_notify: chat_packet_login_session_notify
            chat_packet_type::general_chat_message: chat_packet_general_chat_message
            chat_packet_type::private_chat_message: chat_packet_private_chat_message
            chat_packet_type::user_channel_chat_message: chat_packet_user_channel_chat_message
            chat_packet_type::world_disconnect_request: chat_packet_world_disconnect_request
            chat_packet_type::world_proximity_response: chat_packet_world_proximity_response
            chat_packet_type::world_parcel_response: chat_packet_world_parcel_response
            chat_packet_type::add_friend_request: chat_packet_add_friend_request
            chat_packet_type::add_friend_response: chat_packet_add_friend_response
            chat_packet_type::remove_friend: chat_packet_remove_friend
            chat_packet_type::add_ignore: chat_packet_add_ignore
            chat_packet_type::remove_ignore: chat_packet_remove_ignore
            chat_packet_type::team_missed_invite_check: chat_packet_team_missed_invite_check
            chat_packet_type::team_invite: chat_packet_team_invite
            chat_packet_type::team_invite_response: chat_packet_team_invite_response
            chat_packet_type::team_kick: chat_packet_team_kick
            chat_packet_type::team_leave: chat_packet_team_leave
            chat_packet_type::team_set_loot: chat_packet_team_set_loot
            chat_packet_type::team_set_leader: chat_packet_team_set_leader
            chat_packet_type::guild_create: chat_packet_guild_create
            chat_packet_type::guild_invite: chat_packet_guild_invite
            chat_packet_type::guild_invite_response: chat_packet_guild_invite_response
            chat_packet_type::guild_leave: chat_packet_guild_leave
            chat_packet_type::guild_kick: chat_packet_guild_kick
            chat_packet_type::guild_get_status: chat_packet_guild_get_status
            chat_packet_type::guild_get_all: chat_packet_guild_get_all
            chat_packet_type::show_all: chat_packet_show_all
            chat_packet_type::blueprint_moderated: chat_packet_blueprint_moderated
            chat_packet_type::blueprint_model_ready: chat_packet_blueprint_model_ready
            chat_packet_type::property_ready_for_approval: chat_packet_property_ready_for_approval
            chat_packet_type::property_moderation_changed: chat_packet_property_moderation_changed
            chat_packet_type::property_buildmode_changed: chat_packet_property_buildmode_changed
            chat_packet_type::property_buildmode_changed_report: chat_packet_property_buildmode_changed_report
            chat_packet_type::mail: chat_packet_mail
            chat_packet_type::world_instance_location_request: chat_packet_world_instance_location_request
            chat_packet_type::reputation_update: chat_packet_reputation_update
            chat_packet_type::send_canned_text: chat_packet_send_canned_text
            chat_packet_type::gmlevel_update: chat_packet_gmlevel_update
            chat_packet_type::character_name_change_request: chat_packet_character_name_change_request
            chat_packet_type::csr_request: chat_packet_csr_request
            chat_packet_type::csr_reply: chat_packet_csr_reply
            chat_packet_type::gm_kick: chat_packet_gm_kick
            chat_packet_type::gm_announce: chat_packet_gm_announce
            chat_packet_type::gm_mute: chat_packet_gm_mute
            chat_packet_type::activity_update: chat_packet_activity_update
            chat_packet_type::world_route_packet: chat_packet_world_route_packet
            chat_packet_type::get_zone_populations: chat_packet_get_zone_populations
            chat_packet_type::request_minimum_chat_mode: chat_packet_request_minimum_chat_mode
            chat_packet_type::request_minimum_chat_mode_private: chat_packet_request_minimum_chat_mode_private
            chat_packet_type::match_request: chat_packet_match_request
            chat_packet_type::ugcmanifest_report_missing_file: chat_packet_ugcmanifest_report_missing_file
            chat_packet_type::ugcmanifest_report_done_file: chat_packet_ugcmanifest_report_done_file
            chat_packet_type::ugcmanifest_report_done_blueprint: chat_packet_ugcmanifest_report_done_blueprint
            chat_packet_type::ugcc_request: chat_packet_ugcc_request
            chat_packet_type::who: chat_packet_who
            chat_packet_type::world_players_pet_moderated_acknowledge: chat_packet_world_players_pet_moderated_acknowledge
            chat_packet_type::achievement_notify: chat_packet_achievement_notify
            chat_packet_type::gm_close_private_chat_window: chat_packet_gm_close_private_chat_window
            chat_packet_type::unexpected_disconnect: chat_packet_unexpected_disconnect
            chat_packet_type::player_ready: chat_packet_player_ready
            chat_packet_type::get_donation_total: chat_packet_get_donation_total
            chat_packet_type::update_donation: chat_packet_update_donation
            chat_packet_type::prg_csr_command: chat_packet_prg_csr_command
            chat_packet_type::heartbeat_request_from_world: chat_packet_heartbeat_request_from_world
            chat_packet_type::update_free_trial_status: chat_packet_update_free_trial_status

  chat_packet_login_session_notify:
    seq:
      - id: todo
        type: u1

  chat_packet_general_chat_message:
    seq:
    - id: padding1
      size: 4
    - id: channel_id
      type: u1
      enum: chat_channel
    - id: message_size
      type: u4
    - id: padding2
      size: 73
    - id: message
      type: str
      size: message_size * 2
      encoding: utf-16le
    - id: padding3
      size: 11

  chat_packet_private_chat_message:
    seq:
    - id: channel_id
      type: u1
      enum: chat_channel
    - id: message_len
      type: u4
    - id: padding
      size: 77
    - id: receiver_name
      type: lu_wstring_33
    - id: padding2
      size: 2
    - id: message
      type: str
      size: message_len * 2
      encoding: utf-16le

  chat_packet_user_channel_chat_message:
    seq:
      - id: todo
        type: u1
  chat_packet_world_disconnect_request:
    seq:
      - id: todo
        type: u1
  chat_packet_world_proximity_response:
    seq:
      - id: todo
        type: u1
  chat_packet_world_parcel_response:
    seq:
      - id: todo
        type: u1
  chat_packet_add_friend_request:
    seq:
      - id: todo
        type: u1
  chat_packet_add_friend_response:
    seq:
      - id: todo
        type: u1
  chat_packet_remove_friend:
    seq:
      - id: todo
        type: u1
  chat_packet_add_ignore:
    seq:
      - id: todo
        type: u1
  chat_packet_remove_ignore:
    seq:
      - id: todo
        type: u1
  chat_packet_team_missed_invite_check:
    seq:
      - id: todo
        type: u1
  chat_packet_team_invite:
    seq:
      - id: todo
        type: u1
  chat_packet_team_invite_response:
    seq:
      - id: todo
        type: u1
  chat_packet_team_kick:
    seq:
      - id: todo
        type: u1
  chat_packet_team_leave:
    seq:
      - id: todo
        type: u1
  chat_packet_team_set_loot:
    seq:
      - id: todo
        type: u1
  chat_packet_team_set_leader:
    seq:
      - id: todo
        type: u1
  chat_packet_guild_create:
    seq:
      - id: todo
        type: u1
  chat_packet_guild_invite:
    seq:
      - id: todo
        type: u1
  chat_packet_guild_invite_response:
    seq:
      - id: todo
        type: u1
  chat_packet_guild_leave:
    seq:
      - id: todo
        type: u1
  chat_packet_guild_kick:
    seq:
      - id: todo
        type: u1
  chat_packet_guild_get_status:
    seq:
      - id: todo
        type: u1
  chat_packet_guild_get_all:
    seq:
      - id: todo
        type: u1
  chat_packet_show_all:
    seq:
      - id: todo
        type: u1
  chat_packet_blueprint_moderated:
    seq:
      - id: todo
        type: u1
  chat_packet_blueprint_model_ready:
    seq:
      - id: todo
        type: u1
  chat_packet_property_ready_for_approval:
    seq:
      - id: todo
        type: u1
  chat_packet_property_moderation_changed:
    seq:
      - id: todo
        type: u1
  chat_packet_property_buildmode_changed:
    seq:
      - id: todo
        type: u1
  chat_packet_property_buildmode_changed_report:
    seq:
      - id: todo
        type: u1
  chat_packet_mail:
    seq:
      - id: todo
        type: u1
  chat_packet_world_instance_location_request:
    seq:
      - id: todo
        type: u1
  chat_packet_reputation_update:
    seq:
      - id: todo
        type: u1

  chat_packet_send_canned_text:
    seq:
      - id: is_free_to_play
        type: b1
      - id: source
        type: u2

  chat_packet_gmlevel_update:
    seq:
      - id: todo
        type: u1

  chat_packet_character_name_change_request:
    seq:
      - id: todo
        type: u1
  chat_packet_csr_request:
    seq:
      - id: todo
        type: u1
  chat_packet_csr_reply:
    seq:
      - id: todo
        type: u1
  chat_packet_gm_kick:
    seq:
      - id: todo
        type: u1
  chat_packet_gm_announce:
    seq:
      - id: todo
        type: u1
  chat_packet_gm_mute:
    seq:
      - id: todo
        type: u1
  chat_packet_activity_update:
    seq:
      - id: todo
        type: u1
  chat_packet_world_route_packet:
    seq:
      - id: todo
        type: u1
  chat_packet_get_zone_populations:
    seq:
      - id: todo
        type: u1
  chat_packet_request_minimum_chat_mode:
    seq:
      - id: todo
        type: u1
  chat_packet_request_minimum_chat_mode_private:
    seq:
      - id: todo
        type: u1
  chat_packet_match_request:
    seq:
      - id: todo
        type: u1
  chat_packet_ugcmanifest_report_missing_file:
    seq:
      - id: todo
        type: u1
  chat_packet_ugcmanifest_report_done_file:
    seq:
      - id: todo
        type: u1
  chat_packet_ugcmanifest_report_done_blueprint:
    seq:
      - id: todo
        type: u1
  chat_packet_ugcc_request:
    seq:
      - id: todo
        type: u1
  chat_packet_who:
    seq:
      - id: todo
        type: u1
  chat_packet_world_players_pet_moderated_acknowledge:
    seq:
      - id: todo
        type: u1
  chat_packet_achievement_notify:
    seq:
      - id: padding
        size: 13
      - id: player_name
        type: lu_wstring_33
      - id: padding2
        size: 15
      - id: mission_id
        type: u4
      - id: sender_id
        type: object_id
      - id: chat_receiver
        type: lu_wstring_33

  chat_packet_gm_close_private_chat_window:
    seq:
      - id: todo
        type: u1
  chat_packet_unexpected_disconnect:
    seq:
      - id: todo
        type: u1
  chat_packet_player_ready:
    seq:
      - id: todo
        type: u1
  chat_packet_get_donation_total:
    seq:
      - id: todo
        type: u1
  chat_packet_update_donation:
    seq:
      - id: todo
        type: u1
  chat_packet_prg_csr_command:
    seq:
      - id: todo
        type: u1
  chat_packet_heartbeat_request_from_world:
    seq:
      - id: todo
        type: u1
  chat_packet_update_free_trial_status:
    seq:
    - id: todo
      type: u1

# WORLD MESSAGES
  world_message:
    seq:
      - id: world_packet_id
        type: u4
        enum: world_packet_type
      - id: header_padding
        type: u1
      - id: world_packet_data
        type:
          switch-on: world_packet_id
          cases:
            world_packet_type::general_chat_message: world_packet_general_chat_message
            world_packet_type::route_packet: world_packet_route_packet
            world_packet_type::game_msg: world_packet_game_msg

  world_packet_general_chat_message:
    seq:
    - id: chat_channel_id
      type: u1
      enum: chat_channel
    - id: padding
      type: u2
    - id: message_len
      type: u4
    - id: message
      type: str
      size: message_len * 2
      encoding: ascii

  world_packet_route_packet:
    seq:
    - id: length
      type: u4
    - id: connection_id
      type: u2
      enum: connection_type
    - id: data
      type:
        switch-on: connection_id
        cases:
          connection_type::server: server_message
          connection_type::auth: auth_message
          connection_type::chat: chat_message
          connection_type::chat_internal: chat_internal_message
          connection_type::world: world_message
          connection_type::client: client_message
          connection_type::master: master_message

  world_packet_game_msg:
    seq:
      - id: sender_id
        type: object_id
      - id: game_message_id
        type: u2
        enum: game_message

# SERVER MESSAGES
  server_message:
    seq:
      - id: server_packet_id
        type: u4
        enum: server_packet_type
      - id: header_padding
        type: u1
      - id: server_message_data
        type:
          switch-on: server_packet_id
          cases:
            server_packet_type::version_confirm: server_packet_version_confirm
            server_packet_type::disconnect_notify: server_packet_disconnect_notify
            server_packet_type::general_notify: server_packet_general_notify

  server_packet_version_confirm:
    seq:
      - id: network_version
        type: u4
      - id: padding
        type: u4
      - id: service_id
        type: u4
        enum: service_type

  server_packet_disconnect_notify:
    seq:
      - id: disconnect_notify_id
        type: u4
        enum: disconnect_notify_type

  server_packet_general_notify:
    seq:
      - id: general_notify_id
        type: u4
        enum: general_notify_type
# AUTH MESSAGES
  auth_message:
    seq:
      - id: auth_packet_id
        type: u4
        enum: auth_message_type
      - id: header_padding
        type: u1
# CHAT INTERNAL MESSAGES
  chat_internal_message:
    seq:
      - id: chat_internal_packet_id
        type: u4
        enum: chat_internal_packet_type
      - id: header_padding
        type: u1
# CLIENT MESSAGES
  client_message:
    seq:
      - id: client_packet_id
        type: u4
        enum: client_packet_type
      - id: header_padding
        type: u1
      - id: client_packet_data
        type:
          switch-on: client_packet_id
          cases:
            client_packet_type::login_response: client_packet_login_response
            client_packet_type::load_static_zone: client_packet_load_static_zone
            client_packet_type::create_character: client_packet_create_character
            client_packet_type::character_list_response: client_packet_character_list_response
            client_packet_type::character_create_response: client_packet_character_create_response
            client_packet_type::character_rename_response: client_packet_character_rename_response
            client_packet_type::chat_connect_response: client_packet_chat_connect_response
            client_packet_type::auth_account_create_response: client_packet_auth_account_create_response
            client_packet_type::delete_character_response: client_packet_delete_character_response
            client_packet_type::game_msg: client_packet_game_msg
            client_packet_type::connect_chat: client_packet_connect_chat
            client_packet_type::transfer_to_world: client_packet_transfer_to_world
            client_packet_type::impending_reload_notify: client_packet_impending_reload_notify
            client_packet_type::make_gm_response: client_packet_make_gm_response
            client_packet_type::http_monitor_info_response: client_packet_http_monitor_info_response
            client_packet_type::slash_push_map_response: client_packet_slash_push_map_response
            client_packet_type::slash_pull_map_response: client_packet_slash_pull_map_response
            client_packet_type::slash_lock_map_response: client_packet_slash_lock_map_response
            client_packet_type::blueprint_save_response: client_packet_blueprint_save_response
            client_packet_type::blueprint_lup_save_response: client_packet_blueprint_lup_save_response
            client_packet_type::blueprint_load_response_itemid: client_packet_blueprint_load_response_itemid
            client_packet_type::blueprint_get_all_data_response: client_packet_blueprint_get_all_data_response
            client_packet_type::model_instantiate_response: client_packet_model_instantiate_response
            client_packet_type::debug_output: client_packet_debug_output
            client_packet_type::add_friend_request: client_packet_add_friend_request
            client_packet_type::add_friend_response: client_packet_add_friend_response
            client_packet_type::remove_friend_response: client_packet_remove_friend_response
            client_packet_type::get_friends_list_response: client_packet_get_friends_list_response
            client_packet_type::update_friend_notify: client_packet_update_friend_notify
            client_packet_type::add_ignore_response: client_packet_add_ignore_response
            client_packet_type::remove_ignore_response: client_packet_remove_ignore_response
            client_packet_type::get_ignore_list_response: client_packet_get_ignore_list_response
            client_packet_type::team_invite: client_packet_team_invite
            client_packet_type::team_invite_initial_response: client_packet_team_invite_initial_response
            client_packet_type::guild_create_response: client_packet_guild_create_response
            client_packet_type::guild_get_status_response: client_packet_guild_get_status_response
            client_packet_type::guild_invite: client_packet_guild_invite
            client_packet_type::guild_invite_initial_response: client_packet_guild_invite_initial_response
            client_packet_type::guild_invite_final_response: client_packet_guild_invite_final_response
            client_packet_type::guild_invite_confirm: client_packet_guild_invite_confirm
            client_packet_type::guild_add_player: client_packet_guild_add_player
            client_packet_type::guild_remove_player: client_packet_guild_remove_player
            client_packet_type::guild_login_logout: client_packet_guild_login_logout
            client_packet_type::guild_rank_change: client_packet_guild_rank_change
            client_packet_type::guild_data: client_packet_guild_data
            client_packet_type::guild_status: client_packet_guild_status
            client_packet_type::mail: client_packet_mail
            client_packet_type::db_proxy_result: client_packet_db_proxy_result
            client_packet_type::show_all_response: client_packet_show_all_response
            client_packet_type::who_response: client_packet_who_response
            client_packet_type::send_canned_text: client_packet_send_canned_text
            client_packet_type::update_character_name: client_packet_update_character_name
            client_packet_type::set_network_simulator: client_packet_set_network_simulator
            client_packet_type::invalid_chat_message: client_packet_invalid_chat_message
            client_packet_type::minimum_chat_mode_response: client_packet_minimum_chat_mode_response
            client_packet_type::minimum_chat_mode_response_private: client_packet_minimum_chat_mode_response_private
            client_packet_type::chat_moderation_string: client_packet_chat_moderation_string
            client_packet_type::ugc_manifest_response: client_packet_ugc_manifest_response
            client_packet_type::in_login_queue: client_packet_in_login_queue
            client_packet_type::server_states: client_packet_server_states
            client_packet_type::general_text_for_localization: client_packet_general_text_for_localization
            client_packet_type::update_free_trial_status: client_packet_update_free_trial_status
            client_packet_type::ugc_download_failed: client_packet_ugc_download_failed

  client_packet_login_response:
    seq:
      - id: todo
        type: u1
  client_packet_load_static_zone:
    seq:
      - id: zone_id
        type: zone_id
      - id: checksum
        size: 4
      - id: editor_enabled
        type: b1
      - id: editor_level
        type: u1
      - id: player_position
        type: vector3
      - id: instance_type
        type: u4
  client_packet_create_character:
    seq:
      - id: whole_packet_size
        type: u4
      - id: compressed
        type: u1
      - id: ldf_uncompressed_size
        type: u4
      - id: ldf_length
        type: u4
      - id: ldf_data
        size: ldf_length
  client_packet_character_list_response:
    seq:
      - id: todo
        type: u1
  client_packet_character_create_response:
    seq:
      - id: todo
        type: u1
  client_packet_character_rename_response:
    seq:
      - id: todo
        type: u1
  client_packet_chat_connect_response:
    seq:
      - id: todo
        type: u1
  client_packet_auth_account_create_response:
    seq:
      - id: todo
        type: u1
  client_packet_delete_character_response:
    seq:
      - id: todo
        type: u1
  client_packet_game_msg:
    seq:
      - id: sender_id
        type: object_id
      - id: game_message_id
        type: u2
        enum: game_message
  client_packet_connect_chat:
    seq:
      - id: todo
        type: u1
  client_packet_transfer_to_world:
    seq:
      - id: todo
        type: u1
  client_packet_impending_reload_notify:
    seq:
      - id: todo
        type: u1
  client_packet_make_gm_response:
    seq:
      - id: todo
        type: u1
  client_packet_http_monitor_info_response:
    seq:
      - id: todo
        type: u1
  client_packet_slash_push_map_response:
    seq:
      - id: todo
        type: u1
  client_packet_slash_pull_map_response:
    seq:
      - id: todo
        type: u1
  client_packet_slash_lock_map_response:
    seq:
      - id: todo
        type: u1
  client_packet_blueprint_save_response:
    seq:
      - id: todo
        type: u1
  client_packet_blueprint_lup_save_response:
    seq:
      - id: todo
        type: u1
  client_packet_blueprint_load_response_itemid:
    seq:
      - id: todo
        type: u1
  client_packet_blueprint_get_all_data_response:
    seq:
      - id: todo
        type: u1
  client_packet_model_instantiate_response:
    seq:
      - id: todo
        type: u1
  client_packet_debug_output:
    seq:
      - id: todo
        type: u1
  client_packet_add_friend_request:
    seq:
      - id: todo
        type: u1
  client_packet_add_friend_response:
    seq:
      - id: todo
        type: u1
  client_packet_remove_friend_response:
    seq:
      - id: todo
        type: u1
  client_packet_get_friends_list_response:
    seq:
      - id: todo
        type: u1
  client_packet_update_friend_notify:
    seq:
      - id: todo
        type: u1
  client_packet_add_ignore_response:
    seq:
      - id: todo
        type: u1
  client_packet_remove_ignore_response:
    seq:
      - id: todo
        type: u1
  client_packet_get_ignore_list_response:
    seq:
      - id: todo
        type: u1
  client_packet_team_invite:
    seq:
      - id: todo
        type: u1
  client_packet_team_invite_initial_response:
    seq:
      - id: todo
        type: u1
  client_packet_guild_create_response:
    seq:
      - id: todo
        type: u1
  client_packet_guild_get_status_response:
    seq:
      - id: todo
        type: u1
  client_packet_guild_invite:
    seq:
      - id: todo
        type: u1
  client_packet_guild_invite_initial_response:
    seq:
      - id: todo
        type: u1
  client_packet_guild_invite_final_response:
    seq:
      - id: todo
        type: u1
  client_packet_guild_invite_confirm:
    seq:
      - id: todo
        type: u1
  client_packet_guild_add_player:
    seq:
      - id: todo
        type: u1
  client_packet_guild_remove_player:
    seq:
      - id: todo
        type: u1
  client_packet_guild_login_logout:
    seq:
      - id: todo
        type: u1
  client_packet_guild_rank_change:
    seq:
      - id: todo
        type: u1
  client_packet_guild_data:
    seq:
      - id: todo
        type: u1
  client_packet_guild_status:
    seq:
      - id: todo
        type: u1
  client_packet_mail:
    seq:
      - id: todo
        type: u1
  client_packet_db_proxy_result:
    seq:
      - id: todo
        type: u1
  client_packet_show_all_response:
    seq:
      - id: todo
        type: u1
  client_packet_who_response:
    seq:
      - id: todo
        type: u1
  client_packet_send_canned_text:
    seq:
      - id: todo
        type: u1
  client_packet_update_character_name:
    seq:
      - id: todo
        type: u1
  client_packet_set_network_simulator:
    seq:
      - id: todo
        type: u1
  client_packet_invalid_chat_message:
    seq:
      - id: todo
        type: u1
  client_packet_minimum_chat_mode_response:
    seq:
      - id: todo
        type: u1
  client_packet_minimum_chat_mode_response_private:
    seq:
      - id: todo
        type: u1
  client_packet_chat_moderation_string:
    seq:
      - id: todo
        type: u1
  client_packet_ugc_manifest_response:
    seq:
      - id: todo
        type: u1
  client_packet_in_login_queue:
    seq:
      - id: wait_time
        type: u4
      - id: queue_position
        type: u4
      - id: queue_length
        type: u4
  client_packet_server_states:
    seq:
      - id: chat_server_online
        type: u1
  client_packet_general_text_for_localization:
    seq:
      - id: todo
        type: u1
  client_packet_update_free_trial_status:
    seq:
      - id: is_ftp
        type: u1
  client_packet_ugc_download_failed:
    seq:
      - id: todo
        type: u1
# MASTER MESSAGES
  master_message:
    seq:
      - id: master_packet_id
        type: u4
        enum: master_packet_type
      - id: header_padding
        type: u1

enums:
  chat_message_response_code:
    0: sent
    1: notonline
    2: generalerror
    3: receivednewwhisper
    4: notfriends
    5: senderfreetrial
    6: receiverfreetrial
  service_type:
    0: general
    1: auth
    2: chat
    3: world
    4: client
  disconnect_notify_type:
    0: unknown_server_error
    1: wrong_game_version
    2: wrong_server_version
    3: connection_on_invalid_port
    4: duplicate_login
    5: server_shutdown
    6: server_map_load_failure
    7: invalid_session_key
    8: account_not_in_pending_list
    9: character_not_found
    10: character_corrupted
    11: kick
    12: save_failure
    13: free_trial_expired
    14: play_schedule_time_done
  general_notify_type:
    0: duplicate_login
  messageid:
    0: internal_ping
    1: ping
    2: ping_open_connections
    3: connected_pong
    4: connection_request
    5: secured_connection_response
    6: secured_connection_confirmation
    7: rpc_mapping
    8: detect_lost_connections
    9:  open_connection_request
    10: open_connection_reply
    11: rpc
    12: rpc_reply
    13: out_of_band_internal
    14: connection_request_accepted
    15: connection_attempt_failed
    16: already_connected
    17: new_incoming_connection
    18: no_free_incoming_connections
    19: disconnection_notification
    20: connection_lost
    21: rsa_public_key_mismatch
    22: connection_banned
    23: invalid_password
    24: modified_packet
    25: timestamp
    26: pong
    27: advertise_system
    28: remote_disconnection_notification
    29: remote_connection_lost
    30: remote_new_incoming_connection
    31: download_progress
    32: file_list_transfer_header
    33: file_list_transfer_file
    34: ddt_download_request
    35: transport_string
    36: replica_manager_construction
    37: replica_manager_destruction
    38: replica_manager_scope_change
    39: replica_manager_serialize
    40: replica_manager_download_started
    41: replica_manager_download_complete
    42: connection_graph_request
    43: connection_graph_reply
    44: connection_graph_update
    45: connection_graph_new_connection
    46: connection_graph_connection_lost
    47: connection_graph_disconnection_notification
    48: route_and_multicast
    49: rakvoice_open_channel_request
    50: rakvoice_open_channel_reply
    51: rakvoice_close_channel
    52: rakvoice_data
    53: autopatcher_get_changelist_since_date
    54: autopatcher_creation_list
    55: autopatcher_deletion_list
    56: autopatcher_get_patch
    57: autopatcher_patch_list
    58: autopatcher_repository_fatal_error
    59: autopatcher_finished_internal
    60: autopatcher_finished
    61: autopatcher_restart_application
    62: nat_punchthrough_request
    63: nat_target_not_connected
    64: nat_target_connection_lost
    65: nat_connect_at_time
    66: nat_send_offline_message_at_time
    67: nat_in_progress
    68: database_query_request
    69: database_update_row
    70: database_remove_row
    71: database_query_reply
    72: database_unknown_table
    73: database_incorrect_password
    74: ready_event_set
    75: ready_event_unset
    76: ready_event_all_set
    77: ready_event_query
    78: lobby_general
    79: auto_rpc_call
    80: auto_rpc_remote_index
    81: auto_rpc_unknown_remote_index
    82: rpc_remote_error
    83: user_packet_enum
  connection_type:
    0: server
    1: auth
    2: chat
    3: chat_internal
    4: world
    5: client
    6: master
  master_packet_type:
    1: request_persistent_id
    2: request_persistent_id_response
    3: request_zone_transfer
    4: request_zone_transfer_response
    5: server_info
    6: request_session_key
    7: set_session_key
    8: session_key_response
    9: player_added
    10: player_removed
    11: create_private_zone
    12: request_private_zone
    13: world_ready
    14: prep_zone
    15: shutdown
    16: shutdown_response
    17: shutdown_immediate
    18: shutdown_universe
    19: affirm_transfer_request
    20: affirm_transfer_response
    21: new_session_alert
  client_packet_type:
    0: login_response
    1: logout_response
    2: load_static_zone
    3: create_object
    4: create_character
    5: create_character_extended
    6: character_list_response
    7: character_create_response
    8: character_rename_response
    9: chat_connect_response
    10: auth_account_create_response
    11: delete_character_response
    12: game_msg
    13: connect_chat
    14: transfer_to_world
    15: impending_reload_notify
    16: make_gm_response
    17: http_monitor_info_response
    18: slash_push_map_response
    19: slash_pull_map_response
    20: slash_lock_map_response
    21: blueprint_save_response
    22: blueprint_lup_save_response
    23: blueprint_load_response_itemid
    24: blueprint_get_all_data_response
    25: model_instantiate_response
    26: debug_output
    27: add_friend_request
    28: add_friend_response
    29: remove_friend_response
    30: get_friends_list_response
    31: update_friend_notify
    32: add_ignore_response
    33: remove_ignore_response
    34: get_ignore_list_response
    35: team_invite
    36: team_invite_initial_response
    37: guild_create_response
    38: guild_get_status_response
    39: guild_invite
    40: guild_invite_initial_response
    41: guild_invite_final_response
    42: guild_invite_confirm
    43: guild_add_player
    44: guild_remove_player
    45: guild_login_logout
    46: guild_rank_change
    47: guild_data
    48: guild_status
    49: mail
    50: db_proxy_result
    51: show_all_response
    52: who_response
    53: send_canned_text
    54: update_character_name
    55: set_network_simulator
    56: invalid_chat_message
    57: minimum_chat_mode_response
    58: minimum_chat_mode_response_private
    59: chat_moderation_string
    60: ugc_manifest_response
    61: in_login_queue
    62: server_states
    63: gm_close_target_chat_window
    64: general_text_for_localization
    65: update_free_trial_status
    120: ugc_download_failed
  chat_internal_packet_type:
    0: player_added_notification
    1: player_removed_notification
    2: add_friend
    3: add_best_friend
    4: add_to_team
    5: add_block
    6: remove_friend
    7: remove_block
    8: remove_from_team
    9: delete_team
    10: report
    11: private_chat
    12: private_chat_response
    13: announcement
    14: mail_count_update
    15: mail_send_notify
    16: request_user_list
    17: friend_list
    18: route_to_player
    19: team_update
    20: mute_update
    21: create_team
  server_packet_type:
    0: version_confirm
    1: disconnect_notify
    2: general_notify
  auth_message_type:
    0: login_request
    1: logout_request
    2: create_new_account_request
    3: legointerface_auth_response
    4: sessionkey_received_confirm
    5: runtime_config
  world_packet_type:
    1: validation
    2: character_list_request
    3: character_create_request
    4: login_request
    5: game_msg
    6: character_delete_request
    7: character_rename_request
    8: happy_flower_mode_notify
    9: slash_reload_map
    10: slash_push_map_request
    11: slash_push_map
    12: slash_pull_map
    13: lock_map_request
    14: general_chat_message
    15: http_monitor_info_request
    16: slash_debug_scripts
    17: models_clear
    18: exhibit_insert_model
    19: level_load_complete
    20: tmp_guild_create
    21: route_packet
    22: position_update
    23: mail
    24: word_check
    25: string_check
    26: get_players_in_zone
    27: request_ugc_manifest_info
    28: blueprint_get_all_data_request
    29: cancel_map_queue
    30: handle_funness
    31: fake_prg_csr_message
    32: request_free_trial_refresh
    33: gm_set_free_trial_status
    91: get_top_5_help_issues
  chat_packet_type:
    0: login_session_notify
    1: general_chat_message
    2: private_chat_message
    3: user_channel_chat_message
    4: world_disconnect_request
    5: world_proximity_response
    6: world_parcel_response
    7: add_friend_request
    8: add_friend_response
    9: remove_friend
    10: get_friends_list
    11: add_ignore
    12: remove_ignore
    13: get_ignore_list
    14: team_missed_invite_check
    15: team_invite
    16: team_invite_response
    17: team_kick
    18: team_leave
    19: team_set_loot
    20: team_set_leader
    21: team_get_status
    22: guild_create
    23: guild_invite
    24: guild_invite_response
    25: guild_leave
    26: guild_kick
    27: guild_get_status
    28: guild_get_all
    29: show_all
    30: blueprint_moderated
    31: blueprint_model_ready
    32: property_ready_for_approval
    33: property_moderation_changed
    34: property_buildmode_changed
    35: property_buildmode_changed_report
    36: mail
    37: world_instance_location_request
    38: reputation_update
    39: send_canned_text
    40: gmlevel_update
    41: character_name_change_request
    42: csr_request
    43: csr_reply
    44: gm_kick
    45: gm_announce
    46: gm_mute
    47: activity_update
    48: world_route_packet
    49: get_zone_populations
    50: request_minimum_chat_mode
    51: request_minimum_chat_mode_private
    52: match_request
    53: ugcmanifest_report_missing_file
    54: ugcmanifest_report_done_file
    55: ugcmanifest_report_done_blueprint
    56: ugcc_request
    57: who
    58: world_players_pet_moderated_acknowledge
    59: achievement_notify
    60: gm_close_private_chat_window
    61: unexpected_disconnect
    62: player_ready
    63: get_donation_total
    64: update_donation
    65: prg_csr_command
    66: heartbeat_request_from_world
    67: update_free_trial_status
  chat_channel:
    0: systemnotify
    1: systemwarning
    2: systemerror
    3: broadcast
    4: local
    5: localnoanim
    6: emote
    7: private
    8: team
    9: teamlocal
    10: guild
    11: guildnotify
    12: property
    13: admin
    14: combatdamage
    15: combathealing
    16: combatloot
    17: combatexp
    18: combatdeath
    19: general
    20: trade
    21: lfg
    22: user
  game_message:
    0: get_position
    1: get_rotation
    2: get_linear_velocity
    3: get_angular_velocity
    4: get_forward_velocity
    5: get_player_forward
    6: get_forward_vector
    7: set_position
    8: set_local_position
    9: set_rotation
    10: set_linear_velocity
    11: modify_linear_velocity
    12: set_angular_velocity
    13: modify_angular_velocity
    14: deflect
    15: send_position_update
    16: set_object_scale
    17: get_object_scale
    18: timed_scale_finished
    19: teleport
    20: toggle_player_fwd_to_camera
    21: lock_player_rot_to_camera
    22: unlock_player_rot_from_camera
    23: toggle_player_rot_lock_to_mouse
    24: lock_player_rot_to_mouse
    25: unlock_player_rot_from_mouse
    26: set_player_control_scheme
    27: get_player_control_scheme
    28: reset_player_control_scheme
    29: player_to_previous_control_scheme
    30: drop_client_loot
    34: get_speed
    35: get_rot_speed
    36: is_dead
    37: die
    38: request_die
    39: add_object
    41: play_emote
    42: preload_animation
    43: play_animation
    44: animation_complete
    45: enable_highlight
    46: disable_highlight
    47: get_animation_names
    48: control_behaviors
    52: blend_primary_animation
    53: set_offscreen_animation
    54: get_movement_input_values
    55: swap_texture
    56: swap_color
    57: attach_hair
    58: get_entity_struct
    59: set_entity_struct
    60: set_attr
    61: get_attr
    62: on_hit
    63: hit_or_heal_result
    64: show_attack
    65: go_to
    66: get_config_data
    68: set_config_data
    69: get_inventory_extra_info
    70: get_display_name
    71: get_name
    72: set_name
    73: is_name_localized
    74: get_hair_color
    75: set_hair_color
    76: get_hair_style
    77: set_hair_style
    78: get_head
    79: set_head
    80: get_torso
    81: set_torso
    82: get_legs
    83: set_legs
    84: set_proximity_radius
    85: proximity_update
    86: get_proximity_objects
    87: unset_proximity_radius
    88: clear_proximity_radius
    89: get_proximity_data
    90: set_proximity_radius_icon
    93: toggle_tac_arc
    95: cast_skill
    96: cast_local_skill
    97: echo_local_skill
    98: queue_ai_skill
    99: add_threat_rating
    100: get_threat_rating
    103: clear_threat_list
    111: get_time_for_npc_skill
    112: enemy_heal_notification
    113: reset_scripted_ai_state
    114: enable_combat_ai_component
    115: combat_ai_force_tether
    116: suspend_movement_ai
    117: notify_script_vars_initialized
    118: echo_start_skill
    119: start_skill
    120: caster_dead
    121: verify_ack
    122: add_pending_verify
    123: map_skill
    124: select_skill
    125: cast_active_skill
    126: modify_skill_cooldown
    127: add_skill
    128: remove_skill
    129: log
    130: log_chat
    131: set_max_currency
    132: get_max_currency
    133: set_currency
    134: get_currency
    136: add_pending_currency
    137: pickup_currency
    138: server_delete_loot_item
    139: pickup_item
    140: team_pickup_item
    141: client_delete_loot_item
    143: client_set_loot_item_ffa
    144: collision_phantom
    145: off_collision_phantom
    146: collision_proximity
    147: off_collision_proximity
    148: collision
    149: off_collision
    150: get_skills
    152: clear_fx_single_effect
    153: get_fx_exist_effect
    154: play_fx_effect
    155: stop_fx_effect
    156: clear_fx_all_create_effects
    157: update_fx_all_create_effects
    159: request_resurrect
    160: resurrect
    162: update_from_ghost
    163: fetch_ghost
    164: kfm_loaded
    165: nif_loaded
    166: hkx_loaded
    167: move_to_delete_queue
    168: restore_from_delete_queue
    169: is_enemy
    170: get_faction
    171: set_imagination
    172: get_imagination
    173: set_max_imagination
    174: get_max_imagination
    175: modify_imagination
    176: modify_max_imagination
    177: set_health
    178: get_health
    179: set_max_health
    180: get_max_health
    181: modify_health
    182: modify_max_health
    183: set_armor
    184: get_armor
    185: set_max_armor
    186: get_max_armor
    187: modify_armor
    188: modify_max_armor
    190: pop_health_state
    191: push_equipped_items_state
    192: pop_equipped_items_state
    193: set_gm_level
    194: get_gm_level
    196: add_status_effect
    197: remove_status_effect
    198: set_stunned
    199: get_stunned
    200: set_stun_immunity
    201: get_stun_immunity
    202: knockback
    203: set_visible
    204: get_visible
    205: report_item_info
    207: get_rebuild_state
    209: rebuild_cancel
    211: rebuild_start
    213: enable_rebuild
    214: skill_failure
    216: is_attack_stance
    217: set_object_render
    218: request_mapped_skills
    219: ui_select_mapped_skill
    220: get_inventory_item_in_slot
    221: get_first_inventory_item_by_lot
    222: get_smallest_inventory_stack_by_lot
    224: move_item_in_inventory
    227: add_item_to_inventory_client_sync
    229: get_equipped_items
    230: remove_item_from_inventory
    231: equip_inventory
    233: un_equip_inventory
    234: equip_item
    235: un_equip_item
    236: is_item_respond
    237: is_item_equipped
    238: attach_item
    239: detach_item
    240: get_node
    241: get_lot
    242: is_item_equippable
    243: get_current_animation
    244: get_inv_item_count
    245: post_load_equip
    246: set_physics_active_state
    247: get_current_skill_tac_arc
    248: offer_mission
    249: respond_to_mission
    250: get_mission_state
    251: get_mission_complete_timestamp
    254: notify_mission
    255: notify_mission_task
    257: are_gfx_loaded
    258: added_to_world
    259: remove_extra_gfx_from_pipe
    260: hide_equiped_weapon
    261: un_hide_equiped_weapon
    262: get_item_slot
    263: is_character
    264: set_immunity
    266: toggle_tooltips
    267: get_tooltips_disabled
    268: get_bounding_info
    269: override_bounding_radius
    270: get_offscreen
    271: use_state_machine
    272: add_state
    273: add_sub_state
    274: set_state
    275: set_sub_state
    276: add_message
    277: reload_script
    278: reload_all_scripts
    279: friend_invite_msg
    280: add_friend_reposnse_msg
    281: remove_friend_response_msg
    282: add_friend_from_ui_msg
    283: get_cached_friends_list_msg
    284: request_new_friends_list_msg
    285: repopulate_friends_list_msg
    286: add_ignore_reponse_msg
    287: remove_ignore_response_msg
    288: add_ignore_from_ui_msg
    289: get_cached_ignore_list_msg
    290: request_new_ignore_list_msg
    291: remove_friend_by_name
    292: remove_ignore_by_name
    293: is_player_in_ignore_list_msg
    294: repopulate_ignore_list_msg
    295: get_inventory_list
    296: update_friend_msg
    297: update_friend_name_msg
    298: update_ignore_name_msg
    299: departed
    300: arrived
    301: template_change_waypoints
    302: cancelled
    303: flush_cached_graphics
    304: follow_target
    305: timer_done
    306: timer_cancelled
    307: set_tether_point
    308: get_tether_point
    309: left_tether_radius
    310: get_script_vars_ptr
    311: face_target
    312: rotate_by_degrees
    313: string_rendered
    314: reset_primary_animation
    315: face_play_stream
    316: torso_play_stream
    317: can_pickup
    318: get_inventory_size
    319: get_inventory_count
    320: get_objects_in_group
    321: hide_item
    322: is_object_in_fov
    323: get_type
    324: team_invite_msg
    325: team_get_size
    326: team_request_set_loot
    327: team_remove_player_msg
    328: team_update_player_name_msg
    329: set_updatable
    330: request_team_ui_update
    331: set_collision_group
    332: get_collision_group
    333: get_original_collision_group
    334: set_collision_group_to_original
    335: get_object_radius
    336: rebuild_notify_state
    337: get_player_interaction
    338: set_player_interaction
    339: force_player_to_interact
    340: get_selected_potential_interaction
    341: set_selected_potential_interaction
    342: get_interaction_distance
    343: set_interaction_distance
    344: calculate_interaction_distance
    345: interaction_attempt_from_out_of_range
    346: set_picking_target
    347: client_unuse
    348: begin_pet_interaction
    349: wants_interaction_icon
    350: property_edit_icon_interaction
    351: property_model_interaction
    352: get_interaction_details
    353: get_disabled_interaction_types
    354: get_interaction_info
    355: interaction_game_state_change
    356: toggle_interaction_updates
    357: terminate_interaction
    358: server_terminate_interaction
    359: get_players_target_for_selection
    360: process_interaction_under_cursor
    361: handle_interact_action
    362: attempt_interaction
    363: handle_interaction_camera
    364: request_use
    366: client_use
    367: get_player_multi_interaction
    368: get_multi_interaction_state
    369: vendor_open_window
    370: vendor_close_window
    371: emote_played
    372: emote_received
    373: buy_from_vendor
    374: sell_to_vendor
    375: add_donation_item
    376: remove_donation_item
    378: confirm_donation_on_player
    379: cancel_donation_on_player
    380: team_get_leader
    381: team_get_on_world_members
    382: team_get_all_members
    383: team_set_off_world_flag
    385: set_transparency
    386: get_prefers_fade
    387: projectile_impact
    388: set_projectile_params
    389: set_inventory_size
    391: acknowledge_possession
    392: set_possessed_object
    393: change_possessor
    395: get_possession_type
    396: get_possessed_object
    397: get_possessor
    398: is_possessed
    399: enable_activity
    400: set_shooting_gallery_params
    401: open_activity_start_dialog
    402: request_activity_start_stop
    403: request_activity_enter
    404: request_activity_exit
    405: activity_enter
    406: activity_exit
    407: activity_start
    408: activity_stop
    409: shooting_gallery_client_aim_update
    410: rotate_to_point
    411: shooting_gallery_fire
    412: calculate_firing_parameters
    413: get_muzzle_offset
    414: get_activity_points
    415: team_is_on_world_member
    416: request_vendor_status_update
    417: vendor_status_update
    418: cancel_mission
    419: reset_missions
    420: render_component_ready
    421: send_minifig_decals
    422: physics_component_ready
    423: enter_standby_mode
    424: leave_standby_mode
    425: notify_client_shooting_gallery_score
    426: request_consume_item
    427: consume_client_item
    428: client_item_consumed
    429: query_standby_mode
    430: get_ni_bound
    431: mission_failure
    432: get_animation_time
    434: get_current_activity
    435: set_eyebrows
    436: get_eyebrows
    437: set_eyes
    438: get_eyes
    439: set_mouth
    440: get_mouth
    441: is_object_smashable
    443: smashable_state_changed
    444: use_state_logger
    445: rotate_sub_node
    446: get_sub_node_position
    447: get_sub_node
    448: update_shooting_gallery_rotation
    449: render_floating_text
    450: request2_d_text_element
    451: update2_d_text_element
    452: remove2_d_text_element
    453: set_color
    454: get_color
    455: hkx_character_loaded
    457: activate_physics
    458: set_icon_above_head
    459: add_icon_composite
    460: clear_icon_composites
    461: icon_nif_loaded
    462: icon_kfm_loaded
    463: get_overhead_icon_properties_from_parent
    464: bounce_player
    466: set_user_ctrl_comp_pause
    467: has_collided
    468: get_tooltip_flag
    469: set_tooltip_flag
    470: get_flag
    471: set_flag
    472: notify_client_flag_change
    473: cursor_on
    474: cursor_off
    475: help
    476: vendor_transaction_result
    477: perform_special_death
    478: get_shader_id
    479: get_render_environment
    480: finished_loading_scene
    481: get_skill_info
    482: activity_cancel
    483: mission_uses_object
    484: get_positional_id
    485: set_collectible_status
    486: has_been_collected
    487: has_been_collected_by_client
    488: get_pos_update_stats
    489: get_num_viewers_scoping_this
    490: get_activity_user
    491: get_all_activity_users
    492: get_mission_for_player
    493: set_faction
    494: set_platform_idle_state
    495: display_chat_bubble
    496: request_chat_bubble_element
    497: get_mission_data
    498: spawn_pet
    499: despawn_pet
    500: set_local_space_state
    501: get_local_space_state
    502: set_position_to_local_position
    503: allow_local_space_update
    504: toggle_free_cam_mode
    505: player_loaded
    506: player_added_to_world_local
    507: object_loaded
    508: get_player_ready
    509: player_ready
    510: set_smashable_params
    511: is_lootable_chest
    512: loot_open_window
    513: loot_selection_update
    514: take_loot_chest_item
    515: request_linked_mission
    516: transfer_to_zone
    517: transfer_to_zone_checked_im
    518: secured_transfer_to_zone
    519: invalid_zone_transfer_list
    520: mission_dialogue_ok
    521: get_object_in_scope
    522: set_launched_state
    523: p_create_effect_finished
    524: smashed_object
    525: check_smashchain_override
    526: display_rebuild_activator
    527: transfer_to_last_non_instance
    528: set_active_local_character_id
    529: display_message_box
    530: message_box_respond
    531: choice_box_respond
    532: server_set_user_ctrl_comp_pause
    533: set_character_auto_run
    534: follow_waypoints
    535: swap_decal_and_color
    536: continue_waypoints
    537: smash
    538: un_smash
    539: get_is_smashed
    540: get_up_vector
    541: set_gravity_scale
    542: set_gravity_scale_for_rigid_body
    543: stop_moving
    544: set_pathing_speed
    545: set_shielded
    546: set_shooting_gallery_reticule_effect
    547: place_model_response
    548: set_dodge_info
    549: get_dodge_info
    550: set_skill_attack_speed
    551: get_skill_cooldown_group
    552: get_initial_skill_cooldown
    553: get_skill_cooldown_remaining
    554: get_global_cooldown
    555: set_global_cooldown
    556: reset_global_cooldown
    558: findinventory_item
    559: path_stuck
    560: set_current_path
    561: set_jet_pack_mode
    562: set_jet_pack_time
    563: pet_follow_owner
    564: player_died
    565: register_pet_id
    566: register_pet_dbid
    567: get_pet_id
    568: show_activity_countdown
    569: display_tooltip
    570: set_phantom_base
    571: get_motion_state
    572: get_motion_config
    573: set_active_projectile_skill
    574: initialize_mission_visuals
    575: get_missions
    576: start_activity_time
    577: add_activity_time
    578: guild_get_size
    579: guild_can_we_invite
    580: guild_can_we_kick
    581: set_char_guild_info
    582: get_char_guild_info
    583: get_char_is_in_guild
    584: re_render_name_billboard
    585: is_in_local_char_proximity
    586: guild_set_status
    587: guild_add_player
    588: guild_remove_player
    589: guild_update_player_name
    590: guild_set_player_rank
    591: guild_set_online_status
    592: guild_invite
    593: request_guild_data
    594: populate_guild_data
    595: get_cached_guild_data
    596: guild_render_name
    600: get_is_supported
    601: character_support_changed
    602: activity_pause
    603: use_non_equipment_item
    604: request_use_item_on
    605: request_use_item_on_target
    606: use_item_on
    607: use_item_result
    608: get_parent_obj
    609: set_parent_obj
    610: get_updates_with_parent_position
    611: parent_removed
    612: parent_left_scope
    613: parent_entered_scope
    614: child_loaded
    615: child_removed
    616: child_detached
    617: child_entered_scope
    618: child_left_scope
    619: get_child_objects
    621: zone_transfer_finished
    622: chat_connection_update
    623: platform_at_last_waypoint
    624: loot_take_all
    625: get_equipped_item_info
    626: display_guild_create_box
    627: get_editor_level
    628: get_account_id
    629: get_last_logout
    630: get_last_prop_mod_display_time
    631: set_last_prop_mod_display_time
    632: show_activity_summary
    633: can_receive_all_rewards
    634: get_activity_reward
    635: loot_close_window
    636: get_blueprint_id
    637: notify_blueprint_update
    638: fetch_model_metadata_request
    639: fetch_model_metadata_response
    640: command_pet
    641: pet_response
    642: get_icon_above_head_state
    643: get_icon_above_head
    644: icon_finished_loading
    645: add_pet_state
    646: remove_pet_state
    647: set_pet_state
    648: request_activity_summary_leaderboard_data
    649: send_activity_summary_leaderboard_data
    650: set_on_team
    651: get_pet_has_state
    652: find_property
    653: set_pet_movement_state
    654: get_item_type
    655: get_item_info_key
    656: notify_object
    657: is_pet_wild
    659: client_notify_pet
    660: notify_pet
    661: notify_pet_taming_minigame
    662: start_server_pet_minigame_timer
    663: client_exit_taming_minigame
    664: get_buildmode_active
    665: get_pet_taming_minigame_active
    666: pet_taming_object_picked
    667: pet_taming_minigame_result
    668: pet_taming_try_build_result
    669: set_pet_taming_model
    670: get_pet_taming_model
    671: pet_on_switch
    672: pet_off_switch
    673: notify_taming_build_success
    674: notify_taming_model_loaded_on_server
    675: notify_taming_puzzle_selected
    676: get_instruction_count
    677: get_is_npc
    678: activate_bubble_buff
    679: dectivate_bubble_buff
    680: exhibit_vote
    681: add_pet_to_player
    682: remove_pet_from_player
    683: request_set_pet_name
    684: set_pet_name
    686: pet_name_changed
    687: get_pet_at_index
    688: get_lot_for_pet_by_dbid
    689: get_name_for_pet_by_dbid
    690: get_active_pet_obj_id
    691: get_active_pet_inventory_obj_id
    692: show_pet_action_button
    693: set_emote_lock_state
    694: get_emote_lock_state
    695: leave_team_msg
    697: team_kick_player_msg
    698: team_set_leader_send_msg
    699: use_item_on_client
    700: does_forward_target_clicking
    701: check_use_requirements
    702: use_requirements_response
    703: use_item_requirements_response
    704: pet_added_to_world
    705: bouncer_triggered
    706: exhibit_query_current_model
    707: exhibit_query_current_model_response
    708: exhibit_attempt_vote
    709: exhibit_vote_response
    710: ehibit_requerymodels
    711: is_skill_active
    712: toggle_active_skill
    713: play_embedded_effect_on_all_clients_near_object
    714: exhibit_get_info
    715: get_property_data
    716: download_property_data
    717: query_property_data
    719: model_moderation_action
    720: notify_server_ugc_review_ready
    721: notify_client_ugc_review_ready
    722: old_use_item_on
    723: find_property_for_sale_response
    724: property_editor_begin
    725: property_editor_end
    726: property_editor_set_mode
    727: toggle_trigger
    728: fire_event
    729: is_minifig_in_a_bubble
    730: get_item_info
    731: mission_needs_lot
    732: stop_pathing
    733: start_pathing
    734: activate_bubble_buff_from_server
    735: deactivate_bubble_buff_from_server
    736: has_skill
    737: notify_client_zone_object
    738: move_object
    739: rotate_object
    740: get_spawner_config_data
    741: update_spawner_config_data
    743: turn_around
    744: go_forward
    745: go_backward
    746: update_reputation
    747: get_reputation
    748: add_reputation
    749: update_property_data
    750: property_rental_response
    751: exhibit_placement_response
    752: squirt_with_watergun
    753: get_votes_left
    754: adjust_votes_left
    755: evade_target
    756: stopped_evading
    757: get_pet_has_ability
    760: request_platform_resync
    761: platform_resync
    762: play_cinematic
    763: end_cinematic
    764: cinematic_update
    765: attach_camera_to_rail
    766: detach_camera_from_rail
    767: toggle_ghost_reference_override
    768: set_ghost_reference_position
    769: get_ghost_reference_position
    770: fire_event_server_side
    771: get_pet_ability_object
    772: team_invite_msg_from_ui
    773: add_camera_effect
    774: remove_camera_effect
    775: remove_all_camera_effects
    776: get_my_properties_in_this_zone
    777: is_model_within_property_bounds
    778: property_data_results
    779: on_un_serialize
    781: script_network_var_update
    783: add_object_to_group
    784: remove_object_from_group
    785: is_object_static
    786: get_has_mission
    787: get_mission_target_lot
    788: get_mission_offerer_lot
    789: use_unique_item
    790: get_is_pet
    791: delete_property
    792: createmodel_from_client
    793: update_model_from_client
    794: delete_model_from_client
    795: show_property_bounds
    796: set_property_i_ds
    797: play_face_decal_animation
    798: add_activity_user
    799: remove_activity_user
    800: get_num_activity_users
    801: activity_user_exists
    805: do_complete_activity_events
    806: set_activity_params
    807: set_activity_user_data
    808: get_activity_user_data
    809: do_calculate_activity_rating
    812: nd_audio_post_setup
    813: nd_audio_pre_shutdown
    814: set_nd_audion_listener_stance
    815: set_up_nd_audio_emiitter
    816: shut_down_nd_audio_emitter
    817: metaify_nd_audio_emitter
    818: un_metaify_nd_audio_emitter
    819: metaify_nd_audio_emitters
    820: un_metaify_nd_audio_emitters
    821: play_nd_audio_emitter
    822: stop_nd_audio_emitter
    823: stop_nd_audio_emitter_all
    824: set_nd_audio_emitter_parameter
    825: set_nd_audio_emitters_parameter
    826: nd_audio_callback
    827: activate_nd_audio_music_cue
    828: deactivate_nd_audio_music_cue
    829: flash_nd_audio_music_cue
    830: set_nd_audio_music_parameter
    831: play2_d_ambient_sound
    832: stop2_d_ambient_sound
    834: play3_d_ambient_sound
    835: stop3_d_ambient_sound
    836: activate_nd_audio_mixer_program
    837: deactivate_nd_audio_mixer_program
    838: update_activity_leaderboard
    839: activity_leaderboard_updated
    840: enter_property1
    841: enter_property2
    842: property_entrance_sync
    843: send_property_population_to_client
    844: sen_property_plaque_vis_update
    845: property_select_query
    848: create_position_string
    849: get_parallel_position
    850: parse_chat_message
    851: set_mission_type_state
    852: get_locations_visited
    853: get_mission_type_states
    854: get_time_played
    855: set_mission_viewed
    856: slash_command_text_feedback
    857: handle_slash_command_kore_debugger
    858: broadcast_text_to_chatbox
    860: open_property_management
    861: open_property_vendor
    862: vote_on_property
    863: update_property_or_model_for_filter_check
    865: notify_player_of_property_submission
    866: notify_player_of_model_submission
    867: physics_system_loaded
    868: client_trade_request
    869: server_trade_request
    870: server_trade_invite
    871: client_trade_reply
    872: server_trade_reply
    873: server_trade_initial_reply
    874: server_trade_final_reply
    875: client_trade_update
    876: server_side_trade_update
    877: server_trade_update
    878: client_trade_cancel
    879: client_side_trade_cancel
    880: client_trade_accept
    881: server_side_trade_accept
    882: server_side_trade_cancel
    883: server_trade_cancel
    884: server_trade_accept
    885: get_trade_info
    886: kf_loaded
    887: bricks_loaded
    888: ready_for_updates
    889: send_ready_for_updates
    890: set_last_custom_build
    891: get_last_custom_build
    892: get_status_effect_by_id
    893: get_all_status_effects
    894: child_render_component_ready
    895: notify_appearance_changed_msg
    896: set_physics_motion_state
    897: get_physics_motion_state
    898: attach_grayscale_effect
    899: attach_fade_effect
    900: attach_change_render_environment_effect
    901: force_movement
    902: cancel_force_movement
    903: set_ignore_projectile_collision
    904: get_ignore_projectile_collision
    905: orient_to_object
    906: orient_to_position
    907: orient_to_angle
    909: notify_client_ugc_model_ready
    911: notify_client_ugc_icon_ready
    912: property_build_mode_changed
    913: property_build_mode_update
    914: property_deletion_action
    915: property_moderation_status_action
    916: property_moderation_status_action_response
    917: property_moderation_status_update
    918: property_needs_gm_attention
    919: property_moderation_changed
    922: inventory_refresh_item_details
    923: inventory_load_custom_icon
    924: get_status_effect_by_type
    925: release_charged_skill
    926: property_reload_db
    927: set_player_target
    928: get_player_target
    929: lock_camera_networked
    930: move_camera_networked
    931: rebuild_activated
    932: bounce_notification
    934: request_client_bounce
    935: get_recent_bounced
    936: set_recent_bounced
    937: set_active_state
    938: get_active_state
    939: has_component_type
    940: get_component_list
    941: responds_to_faction
    942: bouncer_active_status
    943: hf_attributes_push
    944: hf_attributes_pull
    945: hf_attributes_path_display
    946: hf_controls_pull
    947: hf_object_selected
    948: hf_placeholder_update
    949: hf_placeholder_toggle
    950: hf_get_associated_paths
    951: hf_gets_want_path
    952: get_recent_movement_keys
    953: track_recent_movement_keys
    954: physics_movement_notification_request
    955: physics_movement_notification
    956: move_inventory_single
    957: move_inventory_batch
    958: mini_game_set_parameters
    961: mini_game_get_team_skills
    963: mini_game_get_team_score
    967: mini_game_get_player_score
    972: mini_game_get_team_color
    975: mini_game_get_team_players
    976: mini_game_update_client
    977: mini_game_get_team
    978: mini_game_get_parameters
    980: object_activated_client
    983: is_resurrecting
    984: get_item_owner
    985: get_stored_config_data
    986: set_stored_config_data
    988: on_player_ressurected
    989: player_resurrection_finished
    990: transform_changeling_build
    991: return_changeling_build_id
    992: spend_brick_inventory_for_lxfml
    993: brick_inventory_for_lxfml_spent
    995: rebuild_bbb_autosave_msg
    996: set_bbb_autosave
    998: use_bbb_inventory
    999: un_use_bbb_model
    1000: bbb_load_item_request
    1001: bbb_save_request
    1002: bbblup_save_request
    1003: bbb_get_metadata_source_item
    1004: bbb_reset_metadata_source_item
    1005: bbb_save_response
    1006: player_exit
    1008: set_pvp_status
    1009: get_pvp_status
    1010: is_valid_pvp_target
    1011: pvp_render_name
    1012: attach_object
    1013: detach_object
    1014: bounce_succeeded
    1015: get_game_object_pointer
    1016: phantom_hkx_loaded
    1017: delay_create_effect
    1018: choice_build_selection_confirmed
    1019: notify_fade_up_vis_complete
    1020: item_has_new_info
    1021: reset_secondary_animation
    1022: get_pick_type
    1023: set_pick_type
    1024: get_priority_pick_list_type
    1025: request_pick_type_update
    1026: get_override_pick_type
    1027: request_display_object_info
    1028: request_server_object_info
    1029: request_object_info_as_xml
    1030: get_object_report_info
    1031: get_object_report_window_close
    1032: get_object_report_status
    1033: get_mission_data_for_object_report
    1034: get_object_rollover_info
    1035: perform_zone_analysis
    1036: update_hk_visual_ization
    1037: clear_items_owner
    1038: apply_linear_impulse
    1039: apply_angular_impulse
    1040: get_contact_normals
    1041: is_watching_for_emote
    1042: notify_client_object
    1043: display_zone_summary
    1044: zone_summary_dismissed
    1045: get_player_zone_statistic
    1046: modify_player_zone_statistic
    1049: apply_external_force
    1050: get_applied_external_force
    1052: item_equipped
    1053: activity_state_change_request
    1054: override_friction
    1055: arrange_with_item
    1056: check_can_build_with_item
    1057: start_building_with_item
    1058: start_build_session
    1059: finish_build_session
    1060: done_build_session
    1061: start_arranging_with_item
    1062: finish_arranging_with_item
    1063: done_arranging_with_item
    1064: start_arrange_mode
    1065: arrange_mode_with_item
    1066: finish_arrange_mode
    1067: done_arrange_mode
    1068: set_build_mode
    1069: build_mode_set
    1070: confirm_build_mode
    1071: build_mode_confirmation
    1072: build_exit_confirmation
    1073: set_build_mode_confirmed
    1074: build_mode_notification
    1075: build_mode_notification_report
    1076: client_use_module_on
    1077: set_model_to_build
    1078: spawn_model_bricks
    1079: check_precondition
    1080: check_all_preconditions
    1081: notify_client_failed_precondition
    1082: get_is_item_equipped_by_lot
    1083: get_is_item_equipped_by_id
    1084: get_object_direction_vectors
    1085: get_castable_skills
    1086: choicebuild_complete
    1087: get_mission_chat
    1088: get_mission_audio
    1089: module_equipped
    1090: module_dropped
    1091: module_picked_up
    1092: module_info
    1093: move_item_between_inventory_types
    1094: modular_build_begin
    1095: modular_build_end
    1096: modular_build_move_and_equip
    1097: modular_build_finish
    1114: set_registration_for_ui_update
    1115: go_to_waypoint
    1116: arrived_at_desired_waypoint
    1117: check_within_bounds
    1118: attach_to_build_assembly
    1119: set_build_assembly
    1120: reset_build_assembly
    1125: get_inventory_item_info
    1126: get_item_details
    1127: get_build_activator
    1128: get_mission_animation
    1129: mission_dialogue_cancelled
    1130: module_assembly_db_data
    1131: module_assembly_db_data_for_client
    1132: module_assembly_query_data
    1133: module_assembly_hkx_loaded
    1134: module_assembly_nif_loaded
    1135: module_assembly_main_nif_loaded
    1136: module_assembly_kfm_loaded
    1137: get_precondition_info
    1138: get_model_lot
    1139: animation_finished_preloading
    1140: child_build_assembly_complete
    1141: character_unserialized
    1142: character_needs_transition
    1143: set_needs_transition
    1144: echo_sync_skill
    1145: sync_skill
    1146: get_behavior_handle
    1147: add_outstanding_behavior
    1148: request_server_projectile_impact
    1149: off_world_impact_request
    1150: server_impact_request
    1151: do_client_projectile_impact
    1152: module_assembly_part_info
    1153: get_build_type
    1154: check_build_type
    1155: modular_build_convert_model
    1156: do_npc_showcase_model_submission
    1157: get_mission_i_ds_list
    1158: set_showcase_mission_npc_vals
    1159: notify_showcase_mission_np_cof_success
    1160: send_lua_notification_request
    1161: send_lua_notification_cancel
    1162: activator_toggle
    1163: make_physics
    1164: set_respawn_group
    1165: set_player_allowed_respawn
    1166: toggle_sending_position_updates
    1167: toggle_receiving_position_updates
    1168: get_enemy_preconditions
    1169: start_model_visualization
    1170: place_property_model
    1171: property_model_placed
    1172: open_exhibit_replace_model_ui
    1173: replace_showcasemodel
    1174: clear_ui_hook_exhibit_replacement
    1175: attach_flyto_screen_pos
    1176: vehicle_get_debug_info
    1177: vehicle_get_movement_input_values
    1178: activity_timer_set
    1179: activity_timer_update
    1180: activity_timer_get
    1181: activity_timer_stop
    1182: activity_timer_done
    1183: get_attack_priority
    1184: ui_message_server_to_single_client
    1185: ui_message_server_to_all_clients
    1186: set_lose_coins_on_death
    1187: load_effects
    1188: set_custom_build
    1189: activity_timer_reset
    1190: activity_timer_stop_all_timers
    1191: activity_timer_modify
    1192: set_keyfram_transform
    1193: add_activity_owner
    1194: remove_activity_owner
    1195: get_current_activity_owners
    1196: toggle_skill_debugging
    1197: pet_taming_try_build
    1198: report_bug
    1199: report_offensive_model
    1200: report_offensive_property
    1201: get_activity_id
    1202: request_smash_player
    1203: get_times_requested_smash
    1204: response_smash_player
    1205: modify_damage_absorption
    1206: uncast_skill
    1207: get_showcase_model_ready
    1208: is_skill_needed
    1209: get_component_data
    1210: vehicle_set_powerslide_method
    1211: shows_nametag
    1213: fire_event_client_side
    1216: get_requires_name_resubmission
    1217: set_requires_name_resubmission
    1218: toggle_gm_invis
    1219: get_gm_invis
    1220: killed_player
    1221: get_pickup_skills
    1222: get_faction_skill
    1223: change_object_world_state
    1224: get_object_world_state
    1225: visibility_changed
    1226: motion_effect_complete
    1227: toggle_freeze_mode
    1228: shader_render_msg_applied
    1229: player_rename_request
    1230: vehicle_lock_input
    1231: vehicle_unlock_input
    1232: set_air_movement
    1233: movement_state_changed
    1234: skill_movement_cancelled
    1235: air_movement_complete
    1236: cancel_air_movement
    1237: force_minifigure_texture_update
    1238: resync_equipment
    1239: add_component_to_object
    1240: vehicle_get_max_game_speed
    1241: vehicle_get_max_game_speed_with_boost
    1242: get_speed_factor
    1243: freeze_inventory
    1244: add_stat_trigger
    1245: add_stat_trigger_child
    1246: check_triggers_and_fire_if_needed
    1247: stat_event_triggered
    1248: get_current_speed
    1249: racing_player_rank_changed
    1250: racing_player_wrong_way_status_changed
    1251: racing_player_crossed_finish_line
    1252: racing_reset_player_to_last_reset
    1253: racing_server_set_player_lap_and_plane
    1254: racing_set_player_reset_info
    1255: racing_player_info_reset_finished
    1256: racing_player_out_of_track_bounds
    1257: racing_sync_info
    1258: racing_player_keep_alive
    1259: racing_server_keep_alive
    1260: lock_node_rotation
    1261: get_physics_collidable
    1262: set_physics_color_for_debug
    1263: get_physics_color_for_debug
    1264: set_physics_text_and_state_for_debug
    1265: request_info_for_physics_debugger
    1266: get_collidable_at_address
    1267: request_server_get_collidable_report
    1268: collision_point_added
    1269: collision_point_removed
    1270: set_attached
    1271: set_destroyable_model_bricks
    1272: vehicle_set_powerslide_lock_wheels
    1273: vehicle_set_wheel_lock_state
    1274: show_health_bar
    1275: get_shows_health_bar
    1276: notify_vehicle_of_racing_object
    1278: enable_client_equip_mode
    1279: client_equip_mode_was_changed
    1281: vehicle_get_spawn_height
    1284: set_name_billboard_state
    1285: check_targeting_requirements
    1286: vehicle_can_wreck
    1287: attach_render_effect
    1288: detach_render_effect
    1289: is_pet_using_ability
    1290: set_blocking
    1291: get_blocking
    1292: update_blocking
    1293: check_damage_results
    1294: get_object_is_in_render_pipe
    1295: attach_motion_fx_arc
    1296: player_reached_respawn_checkpoint
    1297: get_last_respawn_checkpoint
    1298: get_vehicle_debug_collisions
    1299: visiting_property
    1300: handle_ugc_post_delete_based_on_edit_mode
    1301: handle_ugc_post_create_based_on_edit_mode
    1302: world_check_response
    1303: add_damage_reduction
    1304: remove_damage_reduction
    1305: property_contents_from_client
    1306: get_models_on_property
    1307: is_showcase_display_pedestal
    1308: match_request
    1309: match_response
    1310: match_update
    1311: is_default_skill_active
    1312: property_editor_carry
    1313: get_loot_owner_id
    1314: get_enemy_loot_tag
    1315: get_num_spawned_bricks
    1316: set_item_equip_transform
    1317: get_item_equip_transform
    1318: get_property_budget_info
    1319: chatbox_is_init
    1320: get_spawned_i_ds
    1321: get_immunity
    1322: get_gm_immunity
    1323: process_remote_slash_command
    1324: is_friend_msg
    1325: racing_player_event
    1326: get_property_edit_valid
    1327: refresh_render_asset
    1328: vehicle_apply_stat_change
    1329: zone_loaded_info
    1330: b3_interface_action
    1332: racing_stat_modifiers_from_client
    1333: get_racing_stat_modifiers
    1334: set_racing_stat_modifiers
    1335: get_racing_license_level
    1336: add_equip_cast
    1337: show_billboard_interact_icon
    1338: change_idle_flags
    1339: get_animation_flag
    1340: vehicle_add_passive_boost_action
    1341: vehicle_remove_passive_boost_action
    1342: notify_server_vehicle_add_passive_boost_action
    1343: notify_server_vehicle_remove_passive_boost_action
    1344: vehicle_add_slowdown_action
    1345: vehicle_remove_slowdown_action
    1346: notify_server_vehicle_add_slowdown_action
    1347: notify_server_vehicle_remove_slowdown_action
    1348: force_update_animations
    1349: match_get_data_for_player
    1350: buyback_from_vendor
    1351: set_inventory_filter
    1352: get_inventory_filter
    1353: get_inventory_groups
    1354: get_inventory_group
    1355: update_inventory_group
    1356: update_inventory_ui
    1357: update_inventory_group_contents
    1362: can_remove_item_from_inventory
    1363: drive_this_car
    1364: vehicle_can_add_active_boost
    1365: vehicle_add_active_boost
    1366: set_property_access
    1369: zone_property_model_placed
    1370: zone_property_model_rotated
    1371: zone_property_model_removed_while_equipped
    1372: zone_property_model_equipped
    1373: zone_property_model_picked_up
    1374: zone_property_model_removed
    1381: get_versioning_info
    1382: open_ug_behavior_ui
    1383: vehicle_notify_hit_smashable
    1384: get_tether_radius
    1385: vehicle_notify_hit_exploder
    1386: check_nearest_rocket_launch_pre_conditions
    1387: request_nearest_rocket_launch_pre_conditions
    1389: configure_racing_control_client
    1390: notify_racing_client
    1391: racing_player_hack_car
    1392: racing_player_loaded
    1393: racing_client_ready
    1394: possession_finished_attach
    1395: update_chat_mode
    1396: vehicle_notify_finished_race
    1397: equipped_item_startup
    1400: faction_trigger_item_equipped
    1401: faction_trigger_item_unequipped
    1402: toggle_property_behaviors
    1405: get_ug_object_info
    1406: reset_property_behaviors
    1407: is_property_model_reset
    1408: set_ug_object_name_and_description
    1409: set_consumable_item
    1410: vehicle_get_current_lap
    1411: get_ugid
    1412: set_ugid
    1413: ugid_changed
    1414: racing_get_current_lap_for_player
    1415: sub_item_un_equipped
    1416: set_custom_drop_shadow_texture
    1418: get_player_kit_faction
    1419: used_information_plaque
    1420: racing_enable_wrong_way_reset
    1421: racing_toggle_rubber_banding
    1422: get_racing_control_debug_info
    1423: set_property_bounds_visibility
    1424: set_property_vendor_visibility
    1425: set_equip_state
    1426: notify_combat_ai_state_change
    1430: set_property_model_interactive
    1431: server_state_notify
    1432: get_server_state
    1433: get_icon_for_proximity
    1434: get_lego_club_membership_status
    1435: set_status_immunity
    1436: get_status_immunity
    1437: team_is_member
    1438: activate_brick_mode
    1439: get_build_object_id
    1444: set_animation_enabled
    1446: pause_cooldowns
    1447: force_update_render_node
    1448: set_pet_name_moderated
    1449: toggle_strafe_mode
    1450: set_scheme_speed_scale
    1451: cancel_skill_cast
    1454: check_player_assembly_for_unique_module_by_lot
    1455: module_assembly_db_data_to_lua
    1458: is_ally
    1459: modify_lego_score
    1460: get_lego_score
    1461: get_player_level
    1462: notify_lego_score_update
    1463: set_lego_score
    1466: update_behavior_execution_details
    1468: restore_to_post_load_stats
    1469: pickup_object_error
    1470: check_and_show_inventory_full_tip
    1471: set_rail_movement
    1472: start_rail_movement
    1473: set_up_vector
    1474: cancel_rail_movement
    1475: get_rail_info
    1476: client_rail_movement_ready
    1477: player_rail_arrived_notification
    1478: notify_rail_actovator_state_change
    1479: request_rail_activator_state
    1480: notify_reward_mailed
    1481: update_player_statistic
    1482: is_in_combat
    1483: is_primitive_model_msg
    1484: scale_primitice_model_msg
    1485: modify_ghosting_distance
    1487: primitive_model_changed_msg
    1488: get_proprty_clone_id
    1489: request_leave_property
    1491: requery_property_models
    1492: get_behavior_count
    1493: update_behavior_controls
    1494: module_assembly_lxfml_loaded
    1495: request_assembled_lxfml
    1496: assembled_lxfml_loaded
    1497: get_reorient_up_vector
    1498: modular_assembly_nif_completed
    1499: character_disconnect_before_create
    1500: send_launch_to_previous_zone_to_client
    1501: rocketlaunch_request_default_map_id
    1502: begin_launch
    1503: process_claim_codes
    1504: get_last_zone_id
    1505: add_run_speed_modifier
    1506: remove_run_speed_modifier
    1507: skill_event_fired
    1510: send_hot_property_data
    1511: get_hot_property_data
    1512: get_equipped_items_in_set
    1513: is_item_in_set
    1514: get_inventory_type_for_lot
    1515: get_bank_type_for_lot
    1516: notify_not_enough_inv_space
    1517: import_model_to_bbb
    1518: search_nearby_objects
    1519: search_nearby_objects_request_by_lot
    1520: request_object_position_by_id
    1521: search_nearby_objects_request_by_component
    1522: search_nearby_objects_response
    1523: broadcast_non_standard_collisions
    1524: get_registered_non_standard_collision_group
    1525: broadcast_crushed_notifications
    1526: get_registered_crushed_collision_groups
    1527: is_being_crushed
    1528: get_supporting_object
    1529: treat_rigid_body_collsions_as_fixed
    1530: broadcast_teleported_within_notification
    1531: get_registered_teleported_within_object_group
    1532: get_interpentrating_information
    1533: object_teleported_within
    1534: set_physics_solver_properties
    1535: has_behaviors
    1536: play_behavior_sound
    1537: get_player_behavior_tier
    1538: get_emote_animation_time
    1539: get_character_stat_tracking
    1540: player_inventory_ready
    1541: set_preconditions
    1542: detach_shadow
    1543: get_loot_info
    1544: get_players_on_property
    1545: property_spawn_by_behavior
    1546: notify_property_of_edit_mode
    1547: update_property_performance_cost
    1548: get_property_performance_cost
    1549: get_inventory_item_with_subkey
    1550: display_property_summary_screen
    1551: validate_bbb_model
    1552: bbb_model_validation
    1553: property_entrance_begin
    1554: check_list_of_preconditions_from_lua
    1555: get_propertyin_zone
    1556: get_zone_id_from_multi_zone_entrance
    1557: team_set_leader
    1558: team_invite_confirm
    1559: team_get_status_response
    1560: mini_game_enable_local_teams
    1561: team_invite_final_response
    1562: team_add_player
    1563: team_remove_player
    1564: team_create_local
    1565: team_get_loot
    1566: team_set_loot
    1567: set_zero_impulse_against_collision_groups
    1568: set_center_of_mass_to_physical_center
    1569: set_inertia_inverse
    1570: add_remove_climbing_listener
    1571: get_inventoryitem_details
    1572: perform_client_side_death
    1573: lego_club_access_result
    1574: vehicle_get_is_reversing
    1575: check_claim_code
    1576: get_holiday_event
    1577: set_emotes_enabled
    1578: get_emotes_enabled
    1579: freeze_animation
    1580: localized_announcement_server_to_single_client
    1581: anchor_fx_node
    1582: ws_get_friend_list_message
    1583: ws_add_friend_response
    1584: ws_remove_friend_repsonse
    1585: ws_update_friend_status
    1586: ws_update_friend_name
    1587: is_best_friend
    1588: team_notify_update_mission_task
    1589: vehicle_add_slippery_action
    1590: vehicle_remove_slippery_action
    1591: set_resurrect_restore_values
    1592: get_mass
    1593: set_property_moderation_status
    1594: update_property_model_defaults
    1595: update_propertymodel_count
    1596: get_property_model_count
    1597: is_player_loaded
    1598: attach_render_effect_from_lua
    1599: detach_render_effect_from_lua
    1600: team_is_local
    1602: create_camera_particles
    1603: set_smashable_gravity_factor
    1604: vehicle_set_surface_type_override
    1605: vehicle_notify_hit_imagination
    1606: vehicle_notify_hit_imagination_server
    1607: get_spawned_object_spawner_info
    1608: save_property
    1609: set_property_dirty
    1610: get_property_dirty
    1611: get_model_list_from_plaque
    1612: get_original_position_and_rotation
    1613: vehicle_set_mass_for_collision
    1614: get_inventory_group_count
    1615: get_latest_chat_channel_used
    1616: set_suggest_list_language
    1617: vehicle_stop_boost
    1618: start_celebration_effect
    1619: lock_player
    1620: vehicle_is_input_locked
    1621: get_multi_node
    1622: renew_property
    1623: renew_property_result
    1624: charge_activity_cost
    1625: can_receive_loot
    1626: join_player_faction
    1627: set_proximity_update_rate
    1628: bbb_models_to_save
    1629: belongs_to_faction
    1630: modify_faction
    1631: faction_update
    1632: celebration_completed
    1633: play_primary_module_sounds
    1634: stop_primary_module_sounds
    1635: request_team_player_ui_update
    1636: set_local_team
    1637: team_get_world_members_in_radius
    1638: get_parental_level
    1639: get_objects_message_handlers
    1640: property_featured
    1641: property_notify_model_spawned
    1642: server_done_loading_all_objects
    1643: get_donation_total
    1644: update_donation_values
    1645: delayed_delete_drop_effect_brick
    1646: set_camera_unlock_rotation_state
    1647: add_buff
    1648: remove_buff
    1649: check_for_buff
    1650: team_members_disowns_loot
    1651: get_wheel_template
    1652: add_skill_in_progress
    1653: remove_skill_in_progress
    1654: set_overhead_icon_offset
    1655: set_billboard_offset
    1656: set_chat_bubble_offset
    1657: set_no_team_invites
    1658: reset_model_to_defaults
    1659: is_property_in_edit_mode
    1660: get_objects_in_physics_bounds
    1661: enable_lu_remote
    1662: set_is_using_free_trial
    1663: get_is_using_free_trial
    1664: get_account_free_trial_mode
    1665: toggle_inventory_item_lock
    1666: request_move_item_between_inventory_types
    1667: response_move_item_between_inventory_types
    1668: remove_sub_component
    1669: team_get_loot_members
    1670: get_faction_token_type
    1671: get_subscription_pricing
    1672: inform_afk
    1673: overhead_indicator_created
    1674: set_overhead_indicator_grid_location
    1675: playstream_load_pending
    1676: player_set_camera_cycling_mode
    1677: player_get_camera_cycling_mode
    1678: force_camera_target_cycle
    1679: get_object_config_data
    1680: get_object_config_data_non_const
    1681: scope_changed
    1682: set_allow_jump_without_support
    1683: get_allow_jump_without_support
    1684: set_jump_height_scale
    1685: get_jump_height_scale
    1686: set_velocity_resistance
    1687: get_velocity_resistance
    1688: gate_rush_vehicle_hit_gate
    1689: gate_rush_player_collected_gate
    1690: gate_rush_add_gate
    1691: gate_rush_remove_gate
    1692: notify_vehicle_updated
    1693: vehicle_notify_hit_weapon_powerup
    1694: vehicle_notify_hit_weapon_powerup_server
    1696: local_player_targeted
    1697: skill_count_changed
    1698: do_yaw_rotation
    1699: do_pitch_rotation
    1700: do_roll_rotation
    1701: get_current_loot_matrix
    1702: send_multi_mission_offer_update_i_ds
    1703: set_air_speed_values
    1704: use_launcher
    1705: start_launcher
    1706: stop_launcher
    1707: can_use_jet_pack
    1708: jet_pack_state_changed
    1709: turn_off_jet_pack
    1710: add_player_jet_pack_pad
    1711: set_jet_pack_warning
    1712: jet_pack_disabled
    1713: jet_pack_pad_entered
    1714: update_render_possession_flag
    1715: possessable_get_attach_offset
    1718: attempt_to_craft_item
    1719: craft_attempt_response
    1720: set_c_score
    1721: fill_in_renderer
    1722: toggle_crafting_window
    1724: remove_team_buffs
    1725: request_free_trial_status_refresh
    1726: remove_buffs_applied_by_object
    1727: set_mount_inventory_id
    1728: get_mount_inventory_id
    1730: get_build_cinematic_time_remaining
    1731: jet_pack_flying
    1734: notify_server_level_processing_complete
    1735: notify_level_rewards
    1736: character_version_changed
    1737: set_free_trial_rename_available
    1738: set_projectile_launcher_params
    1739: race_precountdown_done
    1740: check_invite_spamming
    1741: get_respawn_volume_info
    1742: invite_accepted
    1743: teleport_to_nearest_respawn
    1744: set_skill_cancel_on_move
    1745: cancel_move_skill
    1746: server_cancel_move_skill
    1747: client_cancel_move_skill
    1748: end_launch_sequence
    1749: cancel_queue
    1750: update_projectile_launcher_rotation
    1751: get_character_version_info
    1753: get_con_info
    1755: get_skills_for_lot
    1756: dismount_complete
    1757: mount_failure_response
    1758: clear_billboard_offset
    1759: get_inventory_item_animation_flag
    1760: set_jet_pack_allowed
    1761: get_build_time_details
    1762: use_skill_set
    1763: set_skill_set_possessor
    1764: populate_action_bar
    1765: get_component_template_id
    1766: get_possessable_skill_set
    1767: mark_inventory_item_as_active
    1768: update_forged_item
    1769: can_items_be_reforged
    1771: notify_client_rail_start_failed
    1772: get_is_on_rail