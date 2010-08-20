# Sequel Pro dump
# Version 663
# http://code.google.com/p/sequel-pro
#
# Host: localhost (MySQL 5.0.51a-log)
# Database: asap_tickets
# Generation Time: 2010-08-10 17:08:42 +0800
# ************************************************************

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table attachments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `attachments`;

CREATE TABLE `attachments` (
  `id` int(11) NOT NULL auto_increment,
  `container_id` int(11) NOT NULL default '0',
  `container_type` varchar(30) NOT NULL default '',
  `filename` varchar(255) NOT NULL default '',
  `disk_filename` varchar(255) NOT NULL default '',
  `filesize` int(11) NOT NULL default '0',
  `content_type` varchar(255) default '',
  `digest` varchar(40) NOT NULL default '',
  `downloads` int(11) NOT NULL default '0',
  `author_id` int(11) NOT NULL default '0',
  `created_on` datetime default NULL,
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_attachments_on_container_id_and_container_type` (`container_id`,`container_type`),
  KEY `index_attachments_on_author_id` (`author_id`),
  KEY `index_attachments_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table auth_sources
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auth_sources`;

CREATE TABLE `auth_sources` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(30) NOT NULL default '',
  `name` varchar(60) NOT NULL default '',
  `host` varchar(60) default NULL,
  `port` int(11) default NULL,
  `account` varchar(255) default NULL,
  `account_password` varchar(60) default NULL,
  `base_dn` varchar(255) default NULL,
  `attr_login` varchar(30) default NULL,
  `attr_firstname` varchar(30) default NULL,
  `attr_lastname` varchar(30) default NULL,
  `attr_mail` varchar(30) default NULL,
  `onthefly_register` tinyint(1) NOT NULL default '0',
  `tls` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `index_auth_sources_on_id_and_type` (`id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table boards
# ------------------------------------------------------------

DROP TABLE IF EXISTS `boards`;

CREATE TABLE `boards` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL default '',
  `description` varchar(255) default NULL,
  `position` int(11) default '1',
  `topics_count` int(11) NOT NULL default '0',
  `messages_count` int(11) NOT NULL default '0',
  `last_message_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `boards_project_id` (`project_id`),
  KEY `index_boards_on_last_message_id` (`last_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table changes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `changes`;

CREATE TABLE `changes` (
  `id` int(11) NOT NULL auto_increment,
  `changeset_id` int(11) NOT NULL,
  `action` varchar(1) NOT NULL default '',
  `path` varchar(255) NOT NULL default '',
  `from_path` varchar(255) default NULL,
  `from_revision` varchar(255) default NULL,
  `revision` varchar(255) default NULL,
  `branch` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `changesets_changeset_id` (`changeset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table changesets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `changesets`;

CREATE TABLE `changesets` (
  `id` int(11) NOT NULL auto_increment,
  `repository_id` int(11) NOT NULL,
  `revision` varchar(255) NOT NULL,
  `committer` varchar(255) default NULL,
  `committed_on` datetime NOT NULL,
  `comments` text,
  `commit_date` date default NULL,
  `scmid` varchar(255) default NULL,
  `user_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `changesets_repos_rev` (`repository_id`,`revision`),
  KEY `index_changesets_on_user_id` (`user_id`),
  KEY `index_changesets_on_repository_id` (`repository_id`),
  KEY `index_changesets_on_committed_on` (`committed_on`),
  KEY `changesets_repos_scmid` (`repository_id`,`scmid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table changesets_issues
# ------------------------------------------------------------

DROP TABLE IF EXISTS `changesets_issues`;

CREATE TABLE `changesets_issues` (
  `changeset_id` int(11) NOT NULL,
  `issue_id` int(11) NOT NULL,
  UNIQUE KEY `changesets_issues_ids` (`changeset_id`,`issue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table comments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `id` int(11) NOT NULL auto_increment,
  `commented_type` varchar(30) NOT NULL default '',
  `commented_id` int(11) NOT NULL default '0',
  `author_id` int(11) NOT NULL default '0',
  `comments` text,
  `created_on` datetime NOT NULL,
  `updated_on` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `index_comments_on_commented_id_and_commented_type` (`commented_id`,`commented_type`),
  KEY `index_comments_on_author_id` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table custom_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `custom_fields`;

CREATE TABLE `custom_fields` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(30) NOT NULL default '',
  `name` varchar(30) NOT NULL default '',
  `field_format` varchar(30) NOT NULL default '',
  `possible_values` text,
  `regexp` varchar(255) default '',
  `min_length` int(11) NOT NULL default '0',
  `max_length` int(11) NOT NULL default '0',
  `is_required` tinyint(1) NOT NULL default '0',
  `is_for_all` tinyint(1) NOT NULL default '0',
  `is_filter` tinyint(1) NOT NULL default '0',
  `position` int(11) default '1',
  `searchable` tinyint(1) default '0',
  `default_value` text,
  `editable` tinyint(1) default '1',
  PRIMARY KEY  (`id`),
  KEY `index_custom_fields_on_id_and_type` (`id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table custom_fields_projects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `custom_fields_projects`;

CREATE TABLE `custom_fields_projects` (
  `custom_field_id` int(11) NOT NULL default '0',
  `project_id` int(11) NOT NULL default '0',
  KEY `index_custom_fields_projects_on_custom_field_id_and_project_id` (`custom_field_id`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table custom_fields_trackers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `custom_fields_trackers`;

CREATE TABLE `custom_fields_trackers` (
  `custom_field_id` int(11) NOT NULL default '0',
  `tracker_id` int(11) NOT NULL default '0',
  KEY `index_custom_fields_trackers_on_custom_field_id_and_tracker_id` (`custom_field_id`,`tracker_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table custom_values
# ------------------------------------------------------------

DROP TABLE IF EXISTS `custom_values`;

CREATE TABLE `custom_values` (
  `id` int(11) NOT NULL auto_increment,
  `customized_type` varchar(30) NOT NULL default '',
  `customized_id` int(11) NOT NULL default '0',
  `custom_field_id` int(11) NOT NULL default '0',
  `value` text,
  PRIMARY KEY  (`id`),
  KEY `custom_values_customized` (`customized_type`,`customized_id`),
  KEY `index_custom_values_on_custom_field_id` (`custom_field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table documents
# ------------------------------------------------------------

DROP TABLE IF EXISTS `documents`;

CREATE TABLE `documents` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) NOT NULL default '0',
  `category_id` int(11) NOT NULL default '0',
  `title` varchar(60) NOT NULL default '',
  `description` text,
  `created_on` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `documents_project_id` (`project_id`),
  KEY `index_documents_on_category_id` (`category_id`),
  KEY `index_documents_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table enabled_modules
# ------------------------------------------------------------

DROP TABLE IF EXISTS `enabled_modules`;

CREATE TABLE `enabled_modules` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `enabled_modules_project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

LOCK TABLES `enabled_modules` WRITE;
/*!40000 ALTER TABLE `enabled_modules` DISABLE KEYS */;
INSERT INTO `enabled_modules` (`id`,`project_id`,`name`)
VALUES
	(1,1,'issue_tracking'),
	(2,1,'time_tracking'),
	(3,1,'news'),
	(4,1,'documents'),
	(5,1,'files'),
	(6,1,'wiki'),
	(7,1,'repository'),
	(8,1,'boards');

/*!40000 ALTER TABLE `enabled_modules` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table enumerations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `enumerations`;

CREATE TABLE `enumerations` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(30) NOT NULL default '',
  `position` int(11) default '1',
  `is_default` tinyint(1) NOT NULL default '0',
  `type` varchar(255) default NULL,
  `active` tinyint(1) NOT NULL default '1',
  `project_id` int(11) default NULL,
  `parent_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_enumerations_on_project_id` (`project_id`),
  KEY `index_enumerations_on_id_and_type` (`id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

LOCK TABLES `enumerations` WRITE;
/*!40000 ALTER TABLE `enumerations` DISABLE KEYS */;
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`)
VALUES
	(1,'User documentation',1,0,'DocumentCategory',1,NULL,NULL),
	(2,'Technical documentation',2,0,'DocumentCategory',1,NULL,NULL),
	(3,'Low',1,0,'IssuePriority',1,NULL,NULL),
	(4,'Normal',2,1,'IssuePriority',1,NULL,NULL),
	(5,'High',3,0,'IssuePriority',1,NULL,NULL),
	(6,'Urgent',4,0,'IssuePriority',1,NULL,NULL),
	(7,'Immediate',5,0,'IssuePriority',1,NULL,NULL),
	(8,'Design',1,0,'TimeEntryActivity',1,NULL,NULL),
	(9,'Development',2,0,'TimeEntryActivity',1,NULL,NULL);

/*!40000 ALTER TABLE `enumerations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table groups_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `groups_users`;

CREATE TABLE `groups_users` (
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  UNIQUE KEY `groups_users_ids` (`group_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table issue_categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `issue_categories`;

CREATE TABLE `issue_categories` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) NOT NULL default '0',
  `name` varchar(30) NOT NULL default '',
  `assigned_to_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `issue_categories_project_id` (`project_id`),
  KEY `index_issue_categories_on_assigned_to_id` (`assigned_to_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table issue_relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `issue_relations`;

CREATE TABLE `issue_relations` (
  `id` int(11) NOT NULL auto_increment,
  `issue_from_id` int(11) NOT NULL,
  `issue_to_id` int(11) NOT NULL,
  `relation_type` varchar(255) NOT NULL default '',
  `delay` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_issue_relations_on_issue_from_id` (`issue_from_id`),
  KEY `index_issue_relations_on_issue_to_id` (`issue_to_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table issue_statuses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `issue_statuses`;

CREATE TABLE `issue_statuses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(30) NOT NULL default '',
  `is_closed` tinyint(1) NOT NULL default '0',
  `is_default` tinyint(1) NOT NULL default '0',
  `position` int(11) default '1',
  `default_done_ratio` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_issue_statuses_on_position` (`position`),
  KEY `index_issue_statuses_on_is_closed` (`is_closed`),
  KEY `index_issue_statuses_on_is_default` (`is_default`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

LOCK TABLES `issue_statuses` WRITE;
/*!40000 ALTER TABLE `issue_statuses` DISABLE KEYS */;
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`)
VALUES
	(1,'New',0,1,1,NULL),
	(2,'In Progress',0,0,2,NULL),
	(3,'Resolved',0,0,3,NULL),
	(4,'Feedback',0,0,4,NULL),
	(5,'Closed',1,0,5,NULL),
	(6,'Rejected',1,0,6,NULL);

/*!40000 ALTER TABLE `issue_statuses` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table issues
# ------------------------------------------------------------

DROP TABLE IF EXISTS `issues`;

CREATE TABLE `issues` (
  `id` int(11) NOT NULL auto_increment,
  `tracker_id` int(11) NOT NULL default '0',
  `project_id` int(11) NOT NULL default '0',
  `subject` varchar(255) NOT NULL default '',
  `description` text,
  `due_date` date default NULL,
  `category_id` int(11) default NULL,
  `status_id` int(11) NOT NULL default '0',
  `assigned_to_id` int(11) default NULL,
  `priority_id` int(11) NOT NULL default '0',
  `fixed_version_id` int(11) default NULL,
  `author_id` int(11) NOT NULL default '0',
  `lock_version` int(11) NOT NULL default '0',
  `created_on` datetime default NULL,
  `updated_on` datetime default NULL,
  `start_date` date default NULL,
  `done_ratio` int(11) NOT NULL default '0',
  `estimated_hours` float default NULL,
  PRIMARY KEY  (`id`),
  KEY `issues_project_id` (`project_id`),
  KEY `index_issues_on_status_id` (`status_id`),
  KEY `index_issues_on_category_id` (`category_id`),
  KEY `index_issues_on_assigned_to_id` (`assigned_to_id`),
  KEY `index_issues_on_fixed_version_id` (`fixed_version_id`),
  KEY `index_issues_on_tracker_id` (`tracker_id`),
  KEY `index_issues_on_priority_id` (`priority_id`),
  KEY `index_issues_on_author_id` (`author_id`),
  KEY `index_issues_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table journal_details
# ------------------------------------------------------------

DROP TABLE IF EXISTS `journal_details`;

CREATE TABLE `journal_details` (
  `id` int(11) NOT NULL auto_increment,
  `journal_id` int(11) NOT NULL default '0',
  `property` varchar(30) NOT NULL default '',
  `prop_key` varchar(30) NOT NULL default '',
  `old_value` varchar(255) default NULL,
  `value` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `journal_details_journal_id` (`journal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table journals
# ------------------------------------------------------------

DROP TABLE IF EXISTS `journals`;

CREATE TABLE `journals` (
  `id` int(11) NOT NULL auto_increment,
  `journalized_id` int(11) NOT NULL default '0',
  `journalized_type` varchar(30) NOT NULL default '',
  `user_id` int(11) NOT NULL default '0',
  `notes` text,
  `created_on` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `journals_journalized_id` (`journalized_id`,`journalized_type`),
  KEY `index_journals_on_user_id` (`user_id`),
  KEY `index_journals_on_journalized_id` (`journalized_id`),
  KEY `index_journals_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table member_roles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `member_roles`;

CREATE TABLE `member_roles` (
  `id` int(11) NOT NULL auto_increment,
  `member_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `inherited_from` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_member_roles_on_member_id` (`member_id`),
  KEY `index_member_roles_on_role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

LOCK TABLES `member_roles` WRITE;
/*!40000 ALTER TABLE `member_roles` DISABLE KEYS */;
INSERT INTO `member_roles` (`id`,`member_id`,`role_id`,`inherited_from`)
VALUES
	(1,1,3,NULL);

/*!40000 ALTER TABLE `member_roles` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table members
# ------------------------------------------------------------

DROP TABLE IF EXISTS `members`;

CREATE TABLE `members` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `project_id` int(11) NOT NULL default '0',
  `created_on` datetime default NULL,
  `mail_notification` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `index_members_on_user_id` (`user_id`),
  KEY `index_members_on_project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` (`id`,`user_id`,`project_id`,`created_on`,`mail_notification`)
VALUES
	(1,3,1,'2010-04-12 10:21:49',0);

/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table messages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` int(11) NOT NULL auto_increment,
  `board_id` int(11) NOT NULL,
  `parent_id` int(11) default NULL,
  `subject` varchar(255) NOT NULL default '',
  `content` text,
  `author_id` int(11) default NULL,
  `replies_count` int(11) NOT NULL default '0',
  `last_reply_id` int(11) default NULL,
  `created_on` datetime NOT NULL,
  `updated_on` datetime NOT NULL,
  `locked` tinyint(1) default '0',
  `sticky` int(11) default '0',
  PRIMARY KEY  (`id`),
  KEY `messages_board_id` (`board_id`),
  KEY `messages_parent_id` (`parent_id`),
  KEY `index_messages_on_last_reply_id` (`last_reply_id`),
  KEY `index_messages_on_author_id` (`author_id`),
  KEY `index_messages_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table news
# ------------------------------------------------------------

DROP TABLE IF EXISTS `news`;

CREATE TABLE `news` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `title` varchar(60) NOT NULL default '',
  `summary` varchar(255) default '',
  `description` text,
  `author_id` int(11) NOT NULL default '0',
  `created_on` datetime default NULL,
  `comments_count` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `news_project_id` (`project_id`),
  KEY `index_news_on_author_id` (`author_id`),
  KEY `index_news_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table open_id_authentication_associations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `open_id_authentication_associations`;

CREATE TABLE `open_id_authentication_associations` (
  `id` int(11) NOT NULL auto_increment,
  `issued` int(11) default NULL,
  `lifetime` int(11) default NULL,
  `handle` varchar(255) default NULL,
  `assoc_type` varchar(255) default NULL,
  `server_url` blob,
  `secret` blob,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table open_id_authentication_nonces
# ------------------------------------------------------------

DROP TABLE IF EXISTS `open_id_authentication_nonces`;

CREATE TABLE `open_id_authentication_nonces` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` int(11) NOT NULL,
  `server_url` varchar(255) default NULL,
  `salt` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table projects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `projects`;

CREATE TABLE `projects` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(30) NOT NULL default '',
  `description` text,
  `homepage` varchar(255) default '',
  `is_public` tinyint(1) NOT NULL default '1',
  `parent_id` int(11) default NULL,
  `created_on` datetime default NULL,
  `updated_on` datetime default NULL,
  `identifier` varchar(20) default NULL,
  `status` int(11) NOT NULL default '1',
  `lft` int(11) default NULL,
  `rgt` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_projects_on_lft` (`lft`),
  KEY `index_projects_on_rgt` (`rgt`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` (`id`,`name`,`description`,`homepage`,`is_public`,`parent_id`,`created_on`,`updated_on`,`identifier`,`status`,`lft`,`rgt`)
VALUES
	(1,'test','test','asdfsdfsdfsdf',1,NULL,'2010-04-12 10:17:53','2010-04-12 10:19:36','test',1,1,2);

/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table projects_trackers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `projects_trackers`;

CREATE TABLE `projects_trackers` (
  `project_id` int(11) NOT NULL default '0',
  `tracker_id` int(11) NOT NULL default '0',
  UNIQUE KEY `projects_trackers_unique` (`project_id`,`tracker_id`),
  KEY `projects_trackers_project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table queries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queries`;

CREATE TABLE `queries` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `name` varchar(255) NOT NULL default '',
  `filters` text,
  `user_id` int(11) NOT NULL default '0',
  `is_public` tinyint(1) NOT NULL default '0',
  `column_names` text,
  `sort_criteria` text,
  `group_by` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_queries_on_project_id` (`project_id`),
  KEY `index_queries_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table repositories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `repositories`;

CREATE TABLE `repositories` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) NOT NULL default '0',
  `url` varchar(255) NOT NULL default '',
  `login` varchar(60) default '',
  `password` varchar(60) default '',
  `root_url` varchar(255) default '',
  `type` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_repositories_on_project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table roles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(30) NOT NULL default '',
  `position` int(11) default '1',
  `assignable` tinyint(1) default '1',
  `builtin` int(11) NOT NULL default '0',
  `permissions` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`,`name`,`position`,`assignable`,`builtin`,`permissions`)
VALUES
	(1,'Non member',1,1,1,'--- \n- :view_issues\n- :add_issues\n- :add_issue_notes\n- :save_queries\n- :view_gantt\n- :view_calendar\n- :view_time_entries\n- :comment_news\n- :view_documents\n- :view_wiki_pages\n- :view_wiki_edits\n- :add_messages\n- :view_files\n- :browse_repository\n- :view_changesets\n'),
	(2,'Anonymous',2,1,2,'--- \n- :view_issues\n- :view_gantt\n- :view_calendar\n- :view_time_entries\n- :view_documents\n- :view_wiki_pages\n- :view_wiki_edits\n- :view_files\n- :browse_repository\n- :view_changesets\n'),
	(3,'Manager',3,1,0,'--- \n- :add_project\n- :edit_project\n- :select_project_modules\n- :manage_members\n- :manage_versions\n- :add_subprojects\n- :manage_categories\n- :view_issues\n- :add_issues\n- :edit_issues\n- :manage_issue_relations\n- :add_issue_notes\n- :edit_issue_notes\n- :edit_own_issue_notes\n- :move_issues\n- :delete_issues\n- :manage_public_queries\n- :save_queries\n- :view_gantt\n- :view_calendar\n- :view_issue_watchers\n- :add_issue_watchers\n- :delete_issue_watchers\n- :log_time\n- :view_time_entries\n- :edit_time_entries\n- :edit_own_time_entries\n- :manage_project_activities\n- :manage_news\n- :comment_news\n- :manage_documents\n- :view_documents\n- :manage_files\n- :view_files\n- :manage_wiki\n- :rename_wiki_pages\n- :delete_wiki_pages\n- :view_wiki_pages\n- :view_wiki_edits\n- :edit_wiki_pages\n- :delete_wiki_pages_attachments\n- :protect_wiki_pages\n- :manage_repository\n- :browse_repository\n- :view_changesets\n- :commit_access\n- :manage_boards\n- :add_messages\n- :edit_messages\n- :edit_own_messages\n- :delete_messages\n- :delete_own_messages\n'),
	(4,'Developer',4,1,0,'--- \n- :manage_versions\n- :manage_categories\n- :view_issues\n- :add_issues\n- :edit_issues\n- :manage_issue_relations\n- :add_issue_notes\n- :save_queries\n- :view_gantt\n- :view_calendar\n- :log_time\n- :view_time_entries\n- :comment_news\n- :view_documents\n- :view_wiki_pages\n- :view_wiki_edits\n- :edit_wiki_pages\n- :delete_wiki_pages\n- :add_messages\n- :edit_own_messages\n- :view_files\n- :manage_files\n- :browse_repository\n- :view_changesets\n- :commit_access\n'),
	(5,'Reporter',5,1,0,'--- \n- :view_issues\n- :add_issues\n- :add_issue_notes\n- :save_queries\n- :view_gantt\n- :view_calendar\n- :log_time\n- :view_time_entries\n- :comment_news\n- :view_documents\n- :view_wiki_pages\n- :view_wiki_edits\n- :add_messages\n- :edit_own_messages\n- :view_files\n- :browse_repository\n- :view_changesets\n');

/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table schema_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `schema_migrations`;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` (`version`)
VALUES
	('1'),
	('10'),
	('100'),
	('101'),
	('102'),
	('103'),
	('104'),
	('105'),
	('106'),
	('107'),
	('108'),
	('11'),
	('12'),
	('13'),
	('14'),
	('15'),
	('16'),
	('17'),
	('18'),
	('19'),
	('2'),
	('20'),
	('20090214190337'),
	('20090312172426'),
	('20090312194159'),
	('20090318181151'),
	('20090323224724'),
	('20090401221305'),
	('20090401231134'),
	('20090403001910'),
	('20090406161854'),
	('20090425161243'),
	('20090503121501'),
	('20090503121505'),
	('20090503121510'),
	('20090614091200'),
	('20090704172350'),
	('20090704172355'),
	('20090704172358'),
	('20091010093521'),
	('20091017212227'),
	('20091017212457'),
	('20091017212644'),
	('20091017212938'),
	('20091017213027'),
	('20091017213113'),
	('20091017213151'),
	('20091017213228'),
	('20091017213257'),
	('20091017213332'),
	('20091017213444'),
	('20091017213536'),
	('20091017213642'),
	('20091017213716'),
	('20091017213757'),
	('20091017213835'),
	('20091017213910'),
	('20091017214015'),
	('20091017214107'),
	('20091017214136'),
	('20091017214236'),
	('20091017214308'),
	('20091017214336'),
	('20091017214406'),
	('20091017214440'),
	('20091017214519'),
	('20091017214611'),
	('20091017214644'),
	('20091017214720'),
	('20091017214750'),
	('20091025163651'),
	('20091108092559'),
	('20091114105931'),
	('20091123212029'),
	('20091205124427'),
	('20091220183509'),
	('20091220183727'),
	('20091220184736'),
	('20091225164732'),
	('20091227112908'),
	('20100221100219'),
	('21'),
	('22'),
	('23'),
	('24'),
	('25'),
	('26'),
	('27'),
	('28'),
	('29'),
	('3'),
	('30'),
	('31'),
	('32'),
	('33'),
	('34'),
	('35'),
	('36'),
	('37'),
	('38'),
	('39'),
	('4'),
	('40'),
	('41'),
	('42'),
	('43'),
	('44'),
	('45'),
	('46'),
	('47'),
	('48'),
	('49'),
	('5'),
	('50'),
	('51'),
	('52'),
	('53'),
	('54'),
	('55'),
	('56'),
	('57'),
	('58'),
	('59'),
	('6'),
	('60'),
	('61'),
	('62'),
	('63'),
	('64'),
	('65'),
	('66'),
	('67'),
	('68'),
	('69'),
	('7'),
	('70'),
	('71'),
	('72'),
	('73'),
	('74'),
	('75'),
	('76'),
	('77'),
	('78'),
	('79'),
	('8'),
	('80'),
	('81'),
	('82'),
	('83'),
	('84'),
	('85'),
	('86'),
	('87'),
	('88'),
	('89'),
	('9'),
	('90'),
	('91'),
	('92'),
	('93'),
	('94'),
	('95'),
	('96'),
	('97'),
	('98'),
	('99');

/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table settings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `settings`;

CREATE TABLE `settings` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `value` text,
  `updated_on` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_settings_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`)
VALUES
	(1,'time_format','','2010-04-12 10:22:11'),
	(2,'gravatar_default','','2010-04-12 10:22:11'),
	(3,'default_language','zh','2010-04-12 10:22:11'),
	(4,'start_of_week','','2010-04-12 10:22:11'),
	(5,'user_format','firstname_lastname','2010-04-12 10:22:11'),
	(6,'date_format','','2010-04-12 10:22:11'),
	(7,'gravatar_enabled','0','2010-04-12 10:22:11'),
	(8,'ui_theme','','2010-04-12 10:22:11');

/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table time_entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `time_entries`;

CREATE TABLE `time_entries` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `issue_id` int(11) default NULL,
  `hours` float NOT NULL,
  `comments` varchar(255) default NULL,
  `activity_id` int(11) NOT NULL,
  `spent_on` date NOT NULL,
  `tyear` int(11) NOT NULL,
  `tmonth` int(11) NOT NULL,
  `tweek` int(11) NOT NULL,
  `created_on` datetime NOT NULL,
  `updated_on` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `time_entries_project_id` (`project_id`),
  KEY `time_entries_issue_id` (`issue_id`),
  KEY `index_time_entries_on_activity_id` (`activity_id`),
  KEY `index_time_entries_on_user_id` (`user_id`),
  KEY `index_time_entries_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `action` varchar(30) NOT NULL default '',
  `value` varchar(40) NOT NULL default '',
  `created_on` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `index_tokens_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` (`id`,`user_id`,`action`,`value`,`created_on`)
VALUES
	(1,1,'feeds','67f1a6153fbab3f9812691a85738162a67478700','2010-04-12 10:17:41');

/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table trackers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `trackers`;

CREATE TABLE `trackers` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(30) NOT NULL default '',
  `is_in_chlog` tinyint(1) NOT NULL default '0',
  `position` int(11) default '1',
  `is_in_roadmap` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

LOCK TABLES `trackers` WRITE;
/*!40000 ALTER TABLE `trackers` DISABLE KEYS */;
INSERT INTO `trackers` (`id`,`name`,`is_in_chlog`,`position`,`is_in_roadmap`)
VALUES
	(1,'Bug',1,1,0),
	(2,'Feature',1,2,1),
	(3,'Support',0,3,0);

/*!40000 ALTER TABLE `trackers` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_preferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_preferences`;

CREATE TABLE `user_preferences` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `others` text,
  `hide_mail` tinyint(1) default '0',
  `time_zone` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_user_preferences_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

LOCK TABLES `user_preferences` WRITE;
/*!40000 ALTER TABLE `user_preferences` DISABLE KEYS */;
INSERT INTO `user_preferences` (`id`,`user_id`,`others`,`hide_mail`,`time_zone`)
VALUES
	(1,1,'--- {}\n\n',0,NULL),
	(2,2,'--- {}\n\n',0,NULL);

/*!40000 ALTER TABLE `user_preferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(30) NOT NULL default '',
  `hashed_password` varchar(40) NOT NULL default '',
  `firstname` varchar(30) NOT NULL default '',
  `lastname` varchar(30) NOT NULL default '',
  `mail` varchar(60) NOT NULL default '',
  `mail_notification` tinyint(1) NOT NULL default '1',
  `admin` tinyint(1) NOT NULL default '0',
  `status` int(11) NOT NULL default '1',
  `last_login_on` datetime default NULL,
  `language` varchar(5) default '',
  `auth_source_id` int(11) default NULL,
  `created_on` datetime default NULL,
  `updated_on` datetime default NULL,
  `type` varchar(255) default NULL,
  `identity_url` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_users_on_id_and_type` (`id`,`type`),
  KEY `index_users_on_auth_source_id` (`auth_source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`,`login`,`hashed_password`,`firstname`,`lastname`,`mail`,`mail_notification`,`admin`,`status`,`last_login_on`,`language`,`auth_source_id`,`created_on`,`updated_on`,`type`,`identity_url`)
VALUES
	(1,'admin','d033e22ae348aeb5660fc2140aec35850c4da997','Redmine','Admin','admin@example.net',1,1,1,'2010-04-12 10:20:27','en',NULL,'2010-04-12 10:17:07','2010-04-12 10:20:27','User',NULL),
	(2,'','','','Anonymous','',0,0,0,NULL,'',NULL,'2010-04-12 10:17:25','2010-04-12 10:17:25','AnonymousUser',NULL),
	(3,'wear','984ff6ee7c78078d4cb1ca08255303fb8741d986','stephen','kong','wear21@hotmail.com',0,0,1,NULL,'en',NULL,'2010-04-12 10:20:16','2010-04-12 10:21:14','User',NULL);

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table versions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `versions`;

CREATE TABLE `versions` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `description` varchar(255) default '',
  `effective_date` date default NULL,
  `created_on` datetime default NULL,
  `updated_on` datetime default NULL,
  `wiki_page_title` varchar(255) default NULL,
  `status` varchar(255) default 'open',
  `sharing` varchar(255) NOT NULL default 'none',
  PRIMARY KEY  (`id`),
  KEY `versions_project_id` (`project_id`),
  KEY `index_versions_on_sharing` (`sharing`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table watchers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `watchers`;

CREATE TABLE `watchers` (
  `id` int(11) NOT NULL auto_increment,
  `watchable_type` varchar(255) NOT NULL default '',
  `watchable_id` int(11) NOT NULL default '0',
  `user_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `watchers_user_id_type` (`user_id`,`watchable_type`),
  KEY `index_watchers_on_user_id` (`user_id`),
  KEY `index_watchers_on_watchable_id_and_watchable_type` (`watchable_id`,`watchable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table wiki_content_versions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `wiki_content_versions`;

CREATE TABLE `wiki_content_versions` (
  `id` int(11) NOT NULL auto_increment,
  `wiki_content_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `author_id` int(11) default NULL,
  `data` longblob,
  `compression` varchar(6) default '',
  `comments` varchar(255) default '',
  `updated_on` datetime NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `wiki_content_versions_wcid` (`wiki_content_id`),
  KEY `index_wiki_content_versions_on_updated_on` (`updated_on`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table wiki_contents
# ------------------------------------------------------------

DROP TABLE IF EXISTS `wiki_contents`;

CREATE TABLE `wiki_contents` (
  `id` int(11) NOT NULL auto_increment,
  `page_id` int(11) NOT NULL,
  `author_id` int(11) default NULL,
  `text` longtext,
  `comments` varchar(255) default '',
  `updated_on` datetime NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `wiki_contents_page_id` (`page_id`),
  KEY `index_wiki_contents_on_author_id` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table wiki_pages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `wiki_pages`;

CREATE TABLE `wiki_pages` (
  `id` int(11) NOT NULL auto_increment,
  `wiki_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_on` datetime NOT NULL,
  `protected` tinyint(1) NOT NULL default '0',
  `parent_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `wiki_pages_wiki_id_title` (`wiki_id`,`title`),
  KEY `index_wiki_pages_on_wiki_id` (`wiki_id`),
  KEY `index_wiki_pages_on_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table wiki_redirects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `wiki_redirects`;

CREATE TABLE `wiki_redirects` (
  `id` int(11) NOT NULL auto_increment,
  `wiki_id` int(11) NOT NULL,
  `title` varchar(255) default NULL,
  `redirects_to` varchar(255) default NULL,
  `created_on` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `wiki_redirects_wiki_id_title` (`wiki_id`,`title`),
  KEY `index_wiki_redirects_on_wiki_id` (`wiki_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table wikis
# ------------------------------------------------------------

DROP TABLE IF EXISTS `wikis`;

CREATE TABLE `wikis` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) NOT NULL,
  `start_page` varchar(255) NOT NULL,
  `status` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `wikis_project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

LOCK TABLES `wikis` WRITE;
/*!40000 ALTER TABLE `wikis` DISABLE KEYS */;
INSERT INTO `wikis` (`id`,`project_id`,`start_page`,`status`)
VALUES
	(1,1,'Wiki',1);

/*!40000 ALTER TABLE `wikis` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table workflows
# ------------------------------------------------------------

DROP TABLE IF EXISTS `workflows`;

CREATE TABLE `workflows` (
  `id` int(11) NOT NULL auto_increment,
  `tracker_id` int(11) NOT NULL default '0',
  `old_status_id` int(11) NOT NULL default '0',
  `new_status_id` int(11) NOT NULL default '0',
  `role_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `wkfs_role_tracker_old_status` (`role_id`,`tracker_id`,`old_status_id`),
  KEY `index_workflows_on_old_status_id` (`old_status_id`),
  KEY `index_workflows_on_role_id` (`role_id`),
  KEY `index_workflows_on_new_status_id` (`new_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=latin1;

LOCK TABLES `workflows` WRITE;
/*!40000 ALTER TABLE `workflows` DISABLE KEYS */;
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`)
VALUES
	(1,1,1,2,3),
	(2,1,1,3,3),
	(3,1,1,4,3),
	(4,1,1,5,3),
	(5,1,1,6,3),
	(6,1,2,1,3),
	(7,1,2,3,3),
	(8,1,2,4,3),
	(9,1,2,5,3),
	(10,1,2,6,3),
	(11,1,3,1,3),
	(12,1,3,2,3),
	(13,1,3,4,3),
	(14,1,3,5,3),
	(15,1,3,6,3),
	(16,1,4,1,3),
	(17,1,4,2,3),
	(18,1,4,3,3),
	(19,1,4,5,3),
	(20,1,4,6,3),
	(21,1,5,1,3),
	(22,1,5,2,3),
	(23,1,5,3,3),
	(24,1,5,4,3),
	(25,1,5,6,3),
	(26,1,6,1,3),
	(27,1,6,2,3),
	(28,1,6,3,3),
	(29,1,6,4,3),
	(30,1,6,5,3),
	(31,2,1,2,3),
	(32,2,1,3,3),
	(33,2,1,4,3),
	(34,2,1,5,3),
	(35,2,1,6,3),
	(36,2,2,1,3),
	(37,2,2,3,3),
	(38,2,2,4,3),
	(39,2,2,5,3),
	(40,2,2,6,3),
	(41,2,3,1,3),
	(42,2,3,2,3),
	(43,2,3,4,3),
	(44,2,3,5,3),
	(45,2,3,6,3),
	(46,2,4,1,3),
	(47,2,4,2,3),
	(48,2,4,3,3),
	(49,2,4,5,3),
	(50,2,4,6,3),
	(51,2,5,1,3),
	(52,2,5,2,3),
	(53,2,5,3,3),
	(54,2,5,4,3),
	(55,2,5,6,3),
	(56,2,6,1,3),
	(57,2,6,2,3),
	(58,2,6,3,3),
	(59,2,6,4,3),
	(60,2,6,5,3),
	(61,3,1,2,3),
	(62,3,1,3,3),
	(63,3,1,4,3),
	(64,3,1,5,3),
	(65,3,1,6,3),
	(66,3,2,1,3),
	(67,3,2,3,3),
	(68,3,2,4,3),
	(69,3,2,5,3),
	(70,3,2,6,3),
	(71,3,3,1,3),
	(72,3,3,2,3),
	(73,3,3,4,3),
	(74,3,3,5,3),
	(75,3,3,6,3),
	(76,3,4,1,3),
	(77,3,4,2,3),
	(78,3,4,3,3),
	(79,3,4,5,3),
	(80,3,4,6,3),
	(81,3,5,1,3),
	(82,3,5,2,3),
	(83,3,5,3,3),
	(84,3,5,4,3),
	(85,3,5,6,3),
	(86,3,6,1,3),
	(87,3,6,2,3),
	(88,3,6,3,3),
	(89,3,6,4,3),
	(90,3,6,5,3),
	(91,1,1,2,4),
	(92,1,1,3,4),
	(93,1,1,4,4),
	(94,1,1,5,4),
	(95,1,2,3,4),
	(96,1,2,4,4),
	(97,1,2,5,4),
	(98,1,3,2,4),
	(99,1,3,4,4),
	(100,1,3,5,4),
	(101,1,4,2,4),
	(102,1,4,3,4),
	(103,1,4,5,4),
	(104,2,1,2,4),
	(105,2,1,3,4),
	(106,2,1,4,4),
	(107,2,1,5,4),
	(108,2,2,3,4),
	(109,2,2,4,4),
	(110,2,2,5,4),
	(111,2,3,2,4),
	(112,2,3,4,4),
	(113,2,3,5,4),
	(114,2,4,2,4),
	(115,2,4,3,4),
	(116,2,4,5,4),
	(117,3,1,2,4),
	(118,3,1,3,4),
	(119,3,1,4,4),
	(120,3,1,5,4),
	(121,3,2,3,4),
	(122,3,2,4,4),
	(123,3,2,5,4),
	(124,3,3,2,4),
	(125,3,3,4,4),
	(126,3,3,5,4),
	(127,3,4,2,4),
	(128,3,4,3,4),
	(129,3,4,5,4),
	(130,1,1,5,5),
	(131,1,2,5,5),
	(132,1,3,5,5),
	(133,1,4,5,5),
	(134,1,3,4,5),
	(135,2,1,5,5),
	(136,2,2,5,5),
	(137,2,3,5,5),
	(138,2,4,5,5),
	(139,2,3,4,5),
	(140,3,1,5,5),
	(141,3,2,5,5),
	(142,3,3,5,5),
	(143,3,4,5,5),
	(144,3,3,4,5);

/*!40000 ALTER TABLE `workflows` ENABLE KEYS */;
UNLOCK TABLES;





/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
