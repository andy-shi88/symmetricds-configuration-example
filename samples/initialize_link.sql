------------------------------------------------------------------------------
-- Sample Symmetric Configuration
------------------------------------------------------------------------------

delete from sym_trigger_router;
delete from sym_trigger;
delete from sym_router;
delete from sym_channel where channel_id in ('sale_transaction', 'item');
delete from sym_node_group_link;
delete from sym_node_group;
delete from sym_node_host;
delete from sym_node_identity;
delete from sym_node_security;
delete from sym_node;


insert into sym_node_group (node_group_id) values ('corp');
insert into sym_node_group (node_group_id) values ('store');

insert into sym_node_group_link (source_node_group_id, target_node_group_id, data_event_action) values ('corp', 'store', 'P');
insert into sym_node_group_link (source_node_group_id, target_node_group_id, data_event_action) values ('store', 'corp', 'W');

insert into sym_router 
(router_id,source_node_group_id,target_node_group_id,router_type,create_time,last_update_time)
values('corp_2_store', 'corp', 'store', 'default',current_timestamp, current_timestamp);

insert into sym_channel 
(channel_id, processing_order, max_batch_size, enabled, description)
values('trade', 1, 100000, 1, 'blockchain trade table');

insert into sym_trigger 
(trigger_id,source_table_name,channel_id,last_update_time,create_time)
values('trade','trade','trade',current_timestamp,current_timestamp);

insert into sym_trigger_router 
(trigger_id,router_id,initial_load_order,last_update_time,create_time)
values('trade','corp_2_store', 100, current_timestamp, current_timestamp);

insert into sym_channel 
(channel_id, processing_order, max_batch_size, enabled, description)
values('block', 1, 100000, 1, 'blockchain block table');

insert into sym_trigger 
(trigger_id,source_table_name,channel_id,last_update_time,create_time)
values('block','block','block',current_timestamp,current_timestamp);

insert into sym_trigger_router 
(trigger_id,router_id,initial_load_order,last_update_time,create_time)
values('block','corp_2_store', 100, current_timestamp, current_timestamp);

insert into sym_channel 
(channel_id, processing_order, max_batch_size, enabled, description)
values('asset', 1, 100000, 1, 'blockchain asset table');

insert into sym_trigger 
(trigger_id,source_table_name,channel_id,last_update_time,create_time)
values('asset','asset','asset',current_timestamp,current_timestamp);

insert into sym_trigger_router 
(trigger_id,router_id,initial_load_order,last_update_time,create_time)
values('asset','corp_2_store', 100, current_timestamp, current_timestamp);

insert into sym_channel 
(channel_id, processing_order, max_batch_size, enabled, description)
values('transaction', 1, 100000, 1, 'blockchain transaction table');

insert into sym_trigger 
(trigger_id,source_table_name,channel_id,last_update_time,create_time)
values('transaction','transaction','transaction',current_timestamp,current_timestamp);

insert into sym_trigger_router 
(trigger_id,router_id,initial_load_order,last_update_time,create_time)
values('transaction','corp_2_store', 100, current_timestamp, current_timestamp);


insert into sym_node (node_id,node_group_id,external_id,sync_enabled,sync_url,schema_version,symmetric_version,database_type,database_version,heartbeat_time,timezone_offset,batch_to_send_count,batch_in_error_count,created_at_node_id) 
 values ('000','corp','000',1,null,null,null,null,null,current_timestamp,null,0,0,'000');
insert into sym_node (node_id,node_group_id,external_id,sync_enabled,sync_url,schema_version,symmetric_version,database_type,database_version,heartbeat_time,timezone_offset,batch_to_send_count,batch_in_error_count,created_at_node_id) 
 values ('001','store','001',1,null,null,null,null,null,current_timestamp,null,0,0,'000');

insert into sym_node_security (node_id,node_password,registration_enabled,registration_time,initial_load_enabled,initial_load_time,created_at_node_id) 
 values ('000','5d1c92bbacbe2edb9e1ca5dbb0e481',0,current_timestamp,0,current_timestamp,'000');
insert into sym_node_security (node_id,node_password,registration_enabled,registration_time,initial_load_enabled,initial_load_time,created_at_node_id) 
 values ('001','5d1c92bbacbe2edb9e1ca5dbb0e481',1,null,1,null,'000');

insert into sym_node_identity values ('000');
