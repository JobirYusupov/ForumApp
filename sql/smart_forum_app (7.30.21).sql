-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июл 30 2021 г., 09:52
-- Версия сервера: 5.7.31
-- Версия PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `smart_forum_app`
--

-- --------------------------------------------------------

--
-- Структура таблицы `access_tokens`
--

DROP TABLE IF EXISTS `access_tokens`;
CREATE TABLE IF NOT EXISTS `access_tokens` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `token` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `last_activity_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_tokens_token_unique` (`token`),
  KEY `access_tokens_user_id_foreign` (`user_id`),
  KEY `access_tokens_type_index` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `api_keys`
--

DROP TABLE IF EXISTS `api_keys`;
CREATE TABLE IF NOT EXISTS `api_keys` (
  `key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `allowed_ips` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `last_activity_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_keys_key_unique` (`key`),
  KEY `api_keys_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `discussions`
--

DROP TABLE IF EXISTS `discussions`;
CREATE TABLE IF NOT EXISTS `discussions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_count` int(11) NOT NULL DEFAULT '1',
  `participant_count` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `post_number_index` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `first_post_id` int(10) UNSIGNED DEFAULT NULL,
  `last_posted_at` datetime DEFAULT NULL,
  `last_posted_user_id` int(10) UNSIGNED DEFAULT NULL,
  `last_post_id` int(10) UNSIGNED DEFAULT NULL,
  `last_post_number` int(10) UNSIGNED DEFAULT NULL,
  `hidden_at` datetime DEFAULT NULL,
  `hidden_user_id` int(10) UNSIGNED DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `is_approved` tinyint(1) NOT NULL DEFAULT '1',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `is_sticky` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `discussions_hidden_user_id_foreign` (`hidden_user_id`),
  KEY `discussions_first_post_id_foreign` (`first_post_id`),
  KEY `discussions_last_post_id_foreign` (`last_post_id`),
  KEY `discussions_last_posted_at_index` (`last_posted_at`),
  KEY `discussions_last_posted_user_id_index` (`last_posted_user_id`),
  KEY `discussions_created_at_index` (`created_at`),
  KEY `discussions_user_id_index` (`user_id`),
  KEY `discussions_comment_count_index` (`comment_count`),
  KEY `discussions_participant_count_index` (`participant_count`),
  KEY `discussions_hidden_at_index` (`hidden_at`),
  KEY `discussions_is_locked_index` (`is_locked`),
  KEY `discussions_is_sticky_created_at_index` (`is_sticky`,`created_at`),
  KEY `discussions_is_sticky_last_posted_at_index` (`is_sticky`,`last_posted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `discussion_tag`
--

DROP TABLE IF EXISTS `discussion_tag`;
CREATE TABLE IF NOT EXISTS `discussion_tag` (
  `discussion_id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`discussion_id`,`tag_id`),
  KEY `discussion_tag_tag_id_foreign` (`tag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `discussion_user`
--

DROP TABLE IF EXISTS `discussion_user`;
CREATE TABLE IF NOT EXISTS `discussion_user` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `discussion_id` int(10) UNSIGNED NOT NULL,
  `last_read_at` datetime DEFAULT NULL,
  `last_read_post_number` int(10) UNSIGNED DEFAULT NULL,
  `subscription` enum('follow','ignore') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`,`discussion_id`),
  KEY `discussion_user_discussion_id_foreign` (`discussion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `email_tokens`
--

DROP TABLE IF EXISTS `email_tokens`;
CREATE TABLE IF NOT EXISTS `email_tokens` (
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`token`),
  KEY `email_tokens_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `flags`
--

DROP TABLE IF EXISTS `flags`;
CREATE TABLE IF NOT EXISTS `flags` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` int(10) UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason_detail` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `flags_post_id_foreign` (`post_id`),
  KEY `flags_user_id_foreign` (`user_id`),
  KEY `flags_created_at_index` (`created_at`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name_singular` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_plural` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `groups`
--

INSERT INTO `groups` (`id`, `name_singular`, `name_plural`, `color`, `icon`, `is_hidden`) VALUES
(1, 'Admin', 'Admins', '#B72A2A', 'fas fa-wrench', 0),
(2, 'Guest', 'Guests', NULL, NULL, 0),
(3, 'Member', 'Members', NULL, NULL, 0),
(4, 'Mod', 'Mods', '#80349E', 'fas fa-bolt', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `group_permission`
--

DROP TABLE IF EXISTS `group_permission`;
CREATE TABLE IF NOT EXISTS `group_permission` (
  `group_id` int(10) UNSIGNED NOT NULL,
  `permission` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`group_id`,`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `group_permission`
--

INSERT INTO `group_permission` (`group_id`, `permission`) VALUES
(2, 'viewForum'),
(3, 'discussion.flagPosts'),
(3, 'discussion.likePosts'),
(3, 'discussion.reply'),
(3, 'discussion.replyWithoutApproval'),
(3, 'discussion.startWithoutApproval'),
(3, 'searchUsers'),
(3, 'startDiscussion'),
(4, 'discussion.approvePosts'),
(4, 'discussion.editPosts'),
(4, 'discussion.hide'),
(4, 'discussion.hidePosts'),
(4, 'discussion.lock'),
(4, 'discussion.rename'),
(4, 'discussion.sticky'),
(4, 'discussion.tag'),
(4, 'discussion.viewFlags'),
(4, 'discussion.viewIpsPosts'),
(4, 'user.suspend'),
(4, 'user.viewLastSeenAt');

-- --------------------------------------------------------

--
-- Структура таблицы `group_user`
--

DROP TABLE IF EXISTS `group_user`;
CREATE TABLE IF NOT EXISTS `group_user` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `group_user_group_id_foreign` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `group_user`
--

INSERT INTO `group_user` (`user_id`, `group_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `login_providers`
--

DROP TABLE IF EXISTS `login_providers`;
CREATE TABLE IF NOT EXISTS `login_providers` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `provider` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_providers_provider_identifier_unique` (`provider`,`identifier`),
  KEY `login_providers_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extension` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `extension`) VALUES
(1, '2015_02_24_000000_create_access_tokens_table', NULL),
(2, '2015_02_24_000000_create_api_keys_table', NULL),
(3, '2015_02_24_000000_create_config_table', NULL),
(4, '2015_02_24_000000_create_discussions_table', NULL),
(5, '2015_02_24_000000_create_email_tokens_table', NULL),
(6, '2015_02_24_000000_create_groups_table', NULL),
(7, '2015_02_24_000000_create_notifications_table', NULL),
(8, '2015_02_24_000000_create_password_tokens_table', NULL),
(9, '2015_02_24_000000_create_permissions_table', NULL),
(10, '2015_02_24_000000_create_posts_table', NULL),
(11, '2015_02_24_000000_create_users_discussions_table', NULL),
(12, '2015_02_24_000000_create_users_groups_table', NULL),
(13, '2015_02_24_000000_create_users_table', NULL),
(14, '2015_09_15_000000_create_auth_tokens_table', NULL),
(15, '2015_09_20_224327_add_hide_to_discussions', NULL),
(16, '2015_09_22_030432_rename_notification_read_time', NULL),
(17, '2015_10_07_130531_rename_config_to_settings', NULL),
(18, '2015_10_24_194000_add_ip_address_to_posts', NULL),
(19, '2015_12_05_042721_change_access_tokens_columns', NULL),
(20, '2015_12_17_194247_change_settings_value_column_to_text', NULL),
(21, '2016_02_04_095452_add_slug_to_discussions', NULL),
(22, '2017_04_07_114138_add_is_private_to_discussions', NULL),
(23, '2017_04_07_114138_add_is_private_to_posts', NULL),
(24, '2018_01_11_093900_change_access_tokens_columns', NULL),
(25, '2018_01_11_094000_change_access_tokens_add_foreign_keys', NULL),
(26, '2018_01_11_095000_change_api_keys_columns', NULL),
(27, '2018_01_11_101800_rename_auth_tokens_to_registration_tokens', NULL),
(28, '2018_01_11_102000_change_registration_tokens_rename_id_to_token', NULL),
(29, '2018_01_11_102100_change_registration_tokens_created_at_to_datetime', NULL),
(30, '2018_01_11_120604_change_posts_table_to_innodb', NULL),
(31, '2018_01_11_155200_change_discussions_rename_columns', NULL),
(32, '2018_01_11_155300_change_discussions_add_foreign_keys', NULL),
(33, '2018_01_15_071700_rename_users_discussions_to_discussion_user', NULL),
(34, '2018_01_15_071800_change_discussion_user_rename_columns', NULL),
(35, '2018_01_15_071900_change_discussion_user_add_foreign_keys', NULL),
(36, '2018_01_15_072600_change_email_tokens_rename_id_to_token', NULL),
(37, '2018_01_15_072700_change_email_tokens_add_foreign_keys', NULL),
(38, '2018_01_15_072800_change_email_tokens_created_at_to_datetime', NULL),
(39, '2018_01_18_130400_rename_permissions_to_group_permission', NULL),
(40, '2018_01_18_130500_change_group_permission_add_foreign_keys', NULL),
(41, '2018_01_18_130600_rename_users_groups_to_group_user', NULL),
(42, '2018_01_18_130700_change_group_user_add_foreign_keys', NULL),
(43, '2018_01_18_133000_change_notifications_columns', NULL),
(44, '2018_01_18_133100_change_notifications_add_foreign_keys', NULL),
(45, '2018_01_18_134400_change_password_tokens_rename_id_to_token', NULL),
(46, '2018_01_18_134500_change_password_tokens_add_foreign_keys', NULL),
(47, '2018_01_18_134600_change_password_tokens_created_at_to_datetime', NULL),
(48, '2018_01_18_135000_change_posts_rename_columns', NULL),
(49, '2018_01_18_135100_change_posts_add_foreign_keys', NULL),
(50, '2018_01_30_112238_add_fulltext_index_to_discussions_title', NULL),
(51, '2018_01_30_220100_create_post_user_table', NULL),
(52, '2018_01_30_222900_change_users_rename_columns', NULL),
(55, '2018_09_15_041340_add_users_indicies', NULL),
(56, '2018_09_15_041828_add_discussions_indicies', NULL),
(57, '2018_09_15_043337_add_notifications_indices', NULL),
(58, '2018_09_15_043621_add_posts_indices', NULL),
(59, '2018_09_22_004100_change_registration_tokens_columns', NULL),
(60, '2018_09_22_004200_create_login_providers_table', NULL),
(61, '2018_10_08_144700_add_shim_prefix_to_group_icons', NULL),
(62, '2019_10_12_195349_change_posts_add_discussion_foreign_key', NULL),
(63, '2020_03_19_134512_change_discussions_default_comment_count', NULL),
(64, '2020_04_21_130500_change_permission_groups_add_is_hidden', NULL),
(65, '2021_03_02_040000_change_access_tokens_add_type', NULL),
(66, '2021_03_02_040500_change_access_tokens_add_id', NULL),
(67, '2021_03_02_041000_change_access_tokens_add_title_ip_agent', NULL),
(68, '2021_04_18_040500_change_migrations_add_id_primary_key', NULL),
(69, '2021_04_18_145100_change_posts_content_column_to_mediumtext', NULL),
(70, '2018_07_21_000000_seed_default_groups', NULL),
(71, '2018_07_21_000100_seed_default_group_permissions', NULL),
(72, '2021_05_10_000000_rename_permissions', NULL),
(73, '2015_09_21_011527_add_is_approved_to_discussions', 'flarum-approval'),
(74, '2015_09_21_011706_add_is_approved_to_posts', 'flarum-approval'),
(75, '2017_07_22_000000_add_default_permissions', 'flarum-approval'),
(76, '2018_09_29_060444_replace_emoji_shorcuts_with_unicode', 'flarum-emoji'),
(77, '2015_09_02_000000_add_flags_read_time_to_users_table', 'flarum-flags'),
(78, '2015_09_02_000000_create_flags_table', 'flarum-flags'),
(79, '2017_07_22_000000_add_default_permissions', 'flarum-flags'),
(80, '2018_06_27_101500_change_flags_rename_time_to_created_at', 'flarum-flags'),
(81, '2018_06_27_101600_change_flags_add_foreign_keys', 'flarum-flags'),
(82, '2018_06_27_105100_change_users_rename_flags_read_time_to_read_flags_at', 'flarum-flags'),
(83, '2018_09_15_043621_add_flags_indices', 'flarum-flags'),
(84, '2019_10_22_000000_change_reason_text_col_type', 'flarum-flags'),
(85, '2015_05_11_000000_create_posts_likes_table', 'flarum-likes'),
(86, '2015_09_04_000000_add_default_like_permissions', 'flarum-likes'),
(87, '2018_06_27_100600_rename_posts_likes_to_post_likes', 'flarum-likes'),
(88, '2018_06_27_100700_change_post_likes_add_foreign_keys', 'flarum-likes'),
(89, '2021_05_10_094200_add_created_at_to_post_likes_table', 'flarum-likes'),
(90, '2015_02_24_000000_add_locked_to_discussions', 'flarum-lock'),
(91, '2017_07_22_000000_add_default_permissions', 'flarum-lock'),
(92, '2018_09_15_043621_add_discussions_indices', 'flarum-lock'),
(93, '2021_03_25_000000_default_settings', 'flarum-markdown'),
(94, '2015_05_11_000000_create_mentions_posts_table', 'flarum-mentions'),
(95, '2015_05_11_000000_create_mentions_users_table', 'flarum-mentions'),
(96, '2018_06_27_102000_rename_mentions_posts_to_post_mentions_post', 'flarum-mentions'),
(97, '2018_06_27_102100_rename_mentions_users_to_post_mentions_user', 'flarum-mentions'),
(98, '2018_06_27_102200_change_post_mentions_post_rename_mentions_id_to_mentions_post_id', 'flarum-mentions'),
(99, '2018_06_27_102300_change_post_mentions_post_add_foreign_keys', 'flarum-mentions'),
(100, '2018_06_27_102400_change_post_mentions_user_rename_mentions_id_to_mentions_user_id', 'flarum-mentions'),
(101, '2018_06_27_102500_change_post_mentions_user_add_foreign_keys', 'flarum-mentions'),
(102, '2021_04_19_000000_set_default_settings', 'flarum-mentions'),
(103, '2015_02_24_000000_add_sticky_to_discussions', 'flarum-sticky'),
(104, '2017_07_22_000000_add_default_permissions', 'flarum-sticky'),
(105, '2018_09_15_043621_add_discussions_indices', 'flarum-sticky'),
(106, '2021_01_13_000000_add_discussion_last_posted_at_indices', 'flarum-sticky'),
(107, '2015_05_11_000000_add_subscription_to_users_discussions_table', 'flarum-subscriptions'),
(108, '2015_05_11_000000_add_suspended_until_to_users_table', 'flarum-suspend'),
(109, '2015_09_14_000000_rename_suspended_until_column', 'flarum-suspend'),
(110, '2017_07_22_000000_add_default_permissions', 'flarum-suspend'),
(111, '2018_06_27_111400_change_users_rename_suspend_until_to_suspended_until', 'flarum-suspend'),
(112, '2015_02_24_000000_create_discussions_tags_table', 'flarum-tags'),
(113, '2015_02_24_000000_create_tags_table', 'flarum-tags'),
(114, '2015_02_24_000000_create_users_tags_table', 'flarum-tags'),
(115, '2015_02_24_000000_set_default_settings', 'flarum-tags'),
(116, '2015_10_19_061223_make_slug_unique', 'flarum-tags'),
(117, '2017_07_22_000000_add_default_permissions', 'flarum-tags'),
(118, '2018_06_27_085200_change_tags_columns', 'flarum-tags'),
(119, '2018_06_27_085300_change_tags_add_foreign_keys', 'flarum-tags'),
(120, '2018_06_27_090400_rename_users_tags_to_tag_user', 'flarum-tags'),
(121, '2018_06_27_100100_change_tag_user_rename_read_time_to_marked_as_read_at', 'flarum-tags'),
(122, '2018_06_27_100200_change_tag_user_add_foreign_keys', 'flarum-tags'),
(123, '2018_06_27_103000_rename_discussions_tags_to_discussion_tag', 'flarum-tags'),
(124, '2018_06_27_103100_add_discussion_tag_foreign_keys', 'flarum-tags'),
(125, '2019_04_21_000000_add_icon_to_tags_table', 'flarum-tags'),
(126, '2020_03_23_rename_flagrow_settings', 'fof-passport');

-- --------------------------------------------------------

--
-- Структура таблицы `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `from_user_id` int(10) UNSIGNED DEFAULT NULL,
  `type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_id` int(10) UNSIGNED DEFAULT NULL,
  `data` blob,
  `created_at` datetime NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `read_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_from_user_id_foreign` (`from_user_id`),
  KEY `notifications_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `password_tokens`
--

DROP TABLE IF EXISTS `password_tokens`;
CREATE TABLE IF NOT EXISTS `password_tokens` (
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`token`),
  KEY `password_tokens_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `discussion_id` int(10) UNSIGNED NOT NULL,
  `number` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` mediumtext COLLATE utf8mb4_unicode_ci COMMENT ' ',
  `edited_at` datetime DEFAULT NULL,
  `edited_user_id` int(10) UNSIGNED DEFAULT NULL,
  `hidden_at` datetime DEFAULT NULL,
  `hidden_user_id` int(10) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `is_approved` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_discussion_id_number_unique` (`discussion_id`,`number`),
  KEY `posts_edited_user_id_foreign` (`edited_user_id`),
  KEY `posts_hidden_user_id_foreign` (`hidden_user_id`),
  KEY `posts_discussion_id_number_index` (`discussion_id`,`number`),
  KEY `posts_discussion_id_created_at_index` (`discussion_id`,`created_at`),
  KEY `posts_user_id_created_at_index` (`user_id`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `post_likes`
--

DROP TABLE IF EXISTS `post_likes`;
CREATE TABLE IF NOT EXISTS `post_likes` (
  `post_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`,`user_id`),
  KEY `post_likes_user_id_foreign` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `post_mentions_post`
--

DROP TABLE IF EXISTS `post_mentions_post`;
CREATE TABLE IF NOT EXISTS `post_mentions_post` (
  `post_id` int(10) UNSIGNED NOT NULL,
  `mentions_post_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`post_id`,`mentions_post_id`),
  KEY `post_mentions_post_mentions_post_id_foreign` (`mentions_post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `post_mentions_user`
--

DROP TABLE IF EXISTS `post_mentions_user`;
CREATE TABLE IF NOT EXISTS `post_mentions_user` (
  `post_id` int(10) UNSIGNED NOT NULL,
  `mentions_user_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`post_id`,`mentions_user_id`),
  KEY `post_mentions_user_mentions_user_id_foreign` (`mentions_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `post_user`
--

DROP TABLE IF EXISTS `post_user`;
CREATE TABLE IF NOT EXISTS `post_user` (
  `post_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`post_id`,`user_id`),
  KEY `post_user_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `registration_tokens`
--

DROP TABLE IF EXISTS `registration_tokens`;
CREATE TABLE IF NOT EXISTS `registration_tokens` (
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_attributes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `settings`
--

INSERT INTO `settings` (`key`, `value`) VALUES
('allow_post_editing', 'reply'),
('allow_renaming', '10'),
('allow_sign_up', '1'),
('custom_less', ''),
('default_locale', 'en'),
('default_route', '/all'),
('extensions_enabled', '[\"flarum-flags\",\"fof-passport\",\"flarum-tags\",\"flarum-suspend\",\"flarum-subscriptions\",\"flarum-sticky\",\"flarum-statistics\",\"flarum-mentions\",\"flarum-markdown\",\"flarum-lock\",\"flarum-likes\",\"flarum-lang-english\",\"flarum-emoji\",\"flarum-bbcode\",\"flarum-approval\"]'),
('flarum-markdown.mdarea', '1'),
('flarum-mentions.allow_username_format', '1'),
('flarum-tags.max_primary_tags', '1'),
('flarum-tags.max_secondary_tags', '3'),
('flarum-tags.min_primary_tags', '1'),
('flarum-tags.min_secondary_tags', '0'),
('fof-passport.app_auth_url', 'https://test.laragroup.uz/oauth/authorize'),
('fof-passport.app_id', '1'),
('fof-passport.app_oauth_scopes', ''),
('fof-passport.app_secret', 'Qsu7XyAo3BmFzcl6kPj6AVfdx6AaXTjgaXdDabIP'),
('fof-passport.app_token_url', 'https://test.laragroup.uz/oauth/token'),
('fof-passport.app_user_url', 'https://test.laragroup.uz/api/user'),
('fof-passport.button_icon', ''),
('fof-passport.button_title', 'Log in with laravel 8'),
('forum_description', ''),
('forum_title', 'Forum App'),
('mail_driver', 'mail'),
('mail_from', 'noreply@forum.app.uz'),
('theme_colored_header', '0'),
('theme_dark_mode', '0'),
('theme_primary_color', '#4D698E'),
('theme_secondary_color', '#4D698E'),
('version', '1.0.4'),
('welcome_message', 'Enjoy your new forum! Hop over to discuss.flarum.org if you have any questions, or to join our community!'),
('welcome_title', 'Welcome to Forum App');

-- --------------------------------------------------------

--
-- Структура таблицы `tags`
--

DROP TABLE IF EXISTS `tags`;
CREATE TABLE IF NOT EXISTS `tags` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `color` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_path` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_mode` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `default_sort` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_restricted` tinyint(1) NOT NULL DEFAULT '0',
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `discussion_count` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `last_posted_at` datetime DEFAULT NULL,
  `last_posted_discussion_id` int(10) UNSIGNED DEFAULT NULL,
  `last_posted_user_id` int(10) UNSIGNED DEFAULT NULL,
  `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tags_slug_unique` (`slug`),
  KEY `tags_parent_id_foreign` (`parent_id`),
  KEY `tags_last_posted_user_id_foreign` (`last_posted_user_id`),
  KEY `tags_last_posted_discussion_id_foreign` (`last_posted_discussion_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `tags`
--

INSERT INTO `tags` (`id`, `name`, `slug`, `description`, `color`, `background_path`, `background_mode`, `position`, `parent_id`, `default_sort`, `is_restricted`, `is_hidden`, `discussion_count`, `last_posted_at`, `last_posted_discussion_id`, `last_posted_user_id`, `icon`) VALUES
(1, 'General', 'general', NULL, '#888', NULL, NULL, 0, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `tag_user`
--

DROP TABLE IF EXISTS `tag_user`;
CREATE TABLE IF NOT EXISTS `tag_user` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL,
  `marked_as_read_at` datetime DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`tag_id`),
  KEY `tag_user_tag_id_foreign` (`tag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_email_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar_url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preferences` blob,
  `joined_at` datetime DEFAULT NULL,
  `last_seen_at` datetime DEFAULT NULL,
  `marked_all_as_read_at` datetime DEFAULT NULL,
  `read_notifications_at` datetime DEFAULT NULL,
  `discussion_count` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `comment_count` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `read_flags_at` datetime DEFAULT NULL,
  `suspended_until` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_joined_at_index` (`joined_at`),
  KEY `users_last_seen_at_index` (`last_seen_at`),
  KEY `users_discussion_count_index` (`discussion_count`),
  KEY `users_comment_count_index` (`comment_count`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `is_email_confirmed`, `password`, `avatar_url`, `preferences`, `joined_at`, `last_seen_at`, `marked_all_as_read_at`, `read_notifications_at`, `discussion_count`, `comment_count`, `read_flags_at`, `suspended_until`) VALUES
(1, 'admin', 'admin@admin.com', 1, '$2y$10$EXMDBjAJ1fGksxjGvZ9CMun9IOp2HfkfXchdy6PyjwVKJgE56Gi2q', NULL, NULL, '2021-07-30 09:31:27', '2021-07-30 09:34:38', NULL, NULL, 0, 0, NULL, NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `discussions`
--
ALTER TABLE `discussions` ADD FULLTEXT KEY `title` (`title`);

--
-- Индексы таблицы `posts`
--
ALTER TABLE `posts` ADD FULLTEXT KEY `content` (`content`);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `access_tokens`
--
ALTER TABLE `access_tokens`
  ADD CONSTRAINT `access_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `api_keys`
--
ALTER TABLE `api_keys`
  ADD CONSTRAINT `api_keys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `discussions`
--
ALTER TABLE `discussions`
  ADD CONSTRAINT `discussions_first_post_id_foreign` FOREIGN KEY (`first_post_id`) REFERENCES `posts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `discussions_hidden_user_id_foreign` FOREIGN KEY (`hidden_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `discussions_last_post_id_foreign` FOREIGN KEY (`last_post_id`) REFERENCES `posts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `discussions_last_posted_user_id_foreign` FOREIGN KEY (`last_posted_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `discussions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `discussion_user`
--
ALTER TABLE `discussion_user`
  ADD CONSTRAINT `discussion_user_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `discussion_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `email_tokens`
--
ALTER TABLE `email_tokens`
  ADD CONSTRAINT `email_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `group_permission`
--
ALTER TABLE `group_permission`
  ADD CONSTRAINT `group_permission_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `group_user`
--
ALTER TABLE `group_user`
  ADD CONSTRAINT `group_user_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `group_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `login_providers`
--
ALTER TABLE `login_providers`
  ADD CONSTRAINT `login_providers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_from_user_id_foreign` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `password_tokens`
--
ALTER TABLE `password_tokens`
  ADD CONSTRAINT `password_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `posts_edited_user_id_foreign` FOREIGN KEY (`edited_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `posts_hidden_user_id_foreign` FOREIGN KEY (`hidden_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `post_user`
--
ALTER TABLE `post_user`
  ADD CONSTRAINT `post_user_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
