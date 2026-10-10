BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book" (
    "id" bigserial PRIMARY KEY,
    "gutenbergId" bigint NOT NULL,
    "title" text NOT NULL,
    "author" text NOT NULL,
    "authorYears" text,
    "handle" text NOT NULL,
    "topics" json NOT NULL,
    "primaryTopic" text NOT NULL,
    "subjects" text NOT NULL DEFAULT ''::text,
    "status" text NOT NULL DEFAULT 'catalogued'::text,
    "featured" boolean NOT NULL DEFAULT false,
    "popularity" bigint NOT NULL DEFAULT 0,
    "chapterCount" bigint NOT NULL DEFAULT 0,
    "wordCount" bigint NOT NULL DEFAULT 0,
    "postCount" bigint NOT NULL DEFAULT 0,
    "followerCount" bigint NOT NULL DEFAULT 0,
    "blurb" text,
    "ingestError" text,
    "ingestAttempts" bigint NOT NULL DEFAULT 0,
    "nextChapterPosition" bigint NOT NULL DEFAULT 0,
    "nextOffset" bigint NOT NULL DEFAULT 0,
    "generationFailures" bigint NOT NULL DEFAULT 0,
    "lastGeneratedAt" timestamp without time zone,
    "queuedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "book_gutenberg_idx" ON "book" USING btree ("gutenbergId");
CREATE UNIQUE INDEX "book_handle_idx" ON "book" USING btree ("handle");
CREATE INDEX "book_status_idx" ON "book" USING btree ("status");
CREATE INDEX "book_featured_idx" ON "book" USING btree ("featured");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book_affinity" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "bookId" bigint NOT NULL,
    "score" double precision NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "book_affinity_unique_idx" ON "book_affinity" USING btree ("profileId", "bookId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book_follow" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "bookId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "book_follow_unique_idx" ON "book_follow" USING btree ("profileId", "bookId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chapter" (
    "id" bigserial PRIMARY KEY,
    "bookId" bigint NOT NULL,
    "position" bigint NOT NULL,
    "title" text NOT NULL,
    "wordCount" bigint NOT NULL,
    "text" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "chapter_book_position_idx" ON "chapter" USING btree ("bookId", "position");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comment" (
    "id" bigserial PRIMARY KEY,
    "postId" bigint NOT NULL,
    "profileId" bigint NOT NULL,
    "parentId" bigint,
    "body" text NOT NULL,
    "likeCount" bigint NOT NULL DEFAULT 0,
    "replyCount" bigint NOT NULL DEFAULT 0,
    "deleted" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "comment_post_idx" ON "comment" USING btree ("postId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comment_like" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "commentId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "comment_like_unique_idx" ON "comment_like" USING btree ("profileId", "commentId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "debate_vote" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "postId" bigint NOT NULL,
    "agree" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "debate_vote_unique_idx" ON "debate_vote" USING btree ("profileId", "postId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "post" (
    "id" bigserial PRIMARY KEY,
    "bookId" bigint NOT NULL,
    "chapterId" bigint NOT NULL,
    "chapterPosition" bigint NOT NULL,
    "kind" text NOT NULL,
    "body" text NOT NULL,
    "quote" text,
    "parts" json,
    "word" text,
    "wordDefinition" text,
    "wordPartOfSpeech" text,
    "quizOptions" json,
    "quizAnswerIndex" bigint,
    "quizExplanation" text,
    "primaryTopic" text NOT NULL,
    "historical" boolean NOT NULL DEFAULT false,
    "passageStart" bigint NOT NULL,
    "passageEnd" bigint NOT NULL,
    "likeCount" bigint NOT NULL DEFAULT 0,
    "commentCount" bigint NOT NULL DEFAULT 0,
    "saveCount" bigint NOT NULL DEFAULT 0,
    "agreeCount" bigint NOT NULL DEFAULT 0,
    "disagreeCount" bigint NOT NULL DEFAULT 0,
    "quizAnswerCount" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "post_book_idx" ON "post" USING btree ("bookId");
CREATE INDEX "post_topic_idx" ON "post" USING btree ("primaryTopic");
CREATE INDEX "post_created_idx" ON "post" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "post_like" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "postId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "post_like_unique_idx" ON "post_like" USING btree ("profileId", "postId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "post_save" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "postId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "post_save_unique_idx" ON "post_save" USING btree ("profileId", "postId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "post_view" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "postId" bigint NOT NULL,
    "dwellMs" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "post_view_unique_idx" ON "post_view" USING btree ("profileId", "postId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "quiz_answer" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "postId" bigint NOT NULL,
    "choiceIndex" bigint NOT NULL,
    "correct" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "quiz_answer_unique_idx" ON "quiz_answer" USING btree ("profileId", "postId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reader" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid,
    "handle" text NOT NULL,
    "displayName" text NOT NULL,
    "bio" text NOT NULL DEFAULT ''::text,
    "field" text,
    "interests" json NOT NULL,
    "dailyGoalMinutes" bigint NOT NULL DEFAULT 15,
    "onboarded" boolean NOT NULL DEFAULT false,
    "avatarHue" bigint NOT NULL DEFAULT 210,
    "streakDays" bigint NOT NULL DEFAULT 0,
    "lastActiveDay" text,
    "tzOffsetMinutes" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "reader_auth_idx" ON "reader" USING btree ("authUserId");
CREATE UNIQUE INDEX "reader_handle_idx" ON "reader" USING btree ("handle");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reading_progress" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "bookId" bigint NOT NULL,
    "chapterPosition" bigint NOT NULL,
    "scrollFraction" double precision NOT NULL DEFAULT 0,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "reading_progress_unique_idx" ON "reading_progress" USING btree ("profileId", "bookId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "report" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "targetType" text NOT NULL,
    "targetId" bigint NOT NULL,
    "reason" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room" (
    "id" bigserial PRIMARY KEY,
    "slug" text NOT NULL,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "topic" text,
    "bookId" bigint,
    "memberCount" bigint NOT NULL DEFAULT 0,
    "messageCount" bigint NOT NULL DEFAULT 0,
    "lastMessageAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "room_slug_idx" ON "room" USING btree ("slug");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_member" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "roomId" bigint NOT NULL,
    "lastReadAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "room_member_unique_idx" ON "room_member" USING btree ("profileId", "roomId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_message" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "profileId" bigint NOT NULL,
    "body" text NOT NULL,
    "deleted" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "room_message_room_idx" ON "room_message" USING btree ("roomId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "saved_word" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "word" text NOT NULL,
    "definition" text NOT NULL,
    "partOfSpeech" text NOT NULL DEFAULT ''::text,
    "example" text,
    "bookTitle" text,
    "postId" bigint,
    "box" bigint NOT NULL DEFAULT 0,
    "reviewCount" bigint NOT NULL DEFAULT 0,
    "dueAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "saved_word_unique_idx" ON "saved_word" USING btree ("profileId", "word");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "study_break" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "plannedMinutes" bigint NOT NULL,
    "startedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "endedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "study_break_profile_idx" ON "study_break" USING btree ("profileId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "topic_affinity" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "topic" text NOT NULL,
    "score" double precision NOT NULL DEFAULT 0
);

-- Indexes
CREATE UNIQUE INDEX "topic_affinity_unique_idx" ON "topic_affinity" USING btree ("profileId", "topic");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_block" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "blockedId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "user_block_unique_idx" ON "user_block" USING btree ("profileId", "blockedId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "book_affinity"
    ADD CONSTRAINT "book_affinity_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "book_affinity"
    ADD CONSTRAINT "book_affinity_fk_1"
    FOREIGN KEY("bookId")
    REFERENCES "book"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "book_follow"
    ADD CONSTRAINT "book_follow_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "book_follow"
    ADD CONSTRAINT "book_follow_fk_1"
    FOREIGN KEY("bookId")
    REFERENCES "book"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "chapter"
    ADD CONSTRAINT "chapter_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "book"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "comment"
    ADD CONSTRAINT "comment_fk_0"
    FOREIGN KEY("postId")
    REFERENCES "post"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comment"
    ADD CONSTRAINT "comment_fk_1"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "comment_like"
    ADD CONSTRAINT "comment_like_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comment_like"
    ADD CONSTRAINT "comment_like_fk_1"
    FOREIGN KEY("commentId")
    REFERENCES "comment"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "debate_vote"
    ADD CONSTRAINT "debate_vote_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "debate_vote"
    ADD CONSTRAINT "debate_vote_fk_1"
    FOREIGN KEY("postId")
    REFERENCES "post"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "post"
    ADD CONSTRAINT "post_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "book"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "post"
    ADD CONSTRAINT "post_fk_1"
    FOREIGN KEY("chapterId")
    REFERENCES "chapter"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "post_like"
    ADD CONSTRAINT "post_like_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "post_like"
    ADD CONSTRAINT "post_like_fk_1"
    FOREIGN KEY("postId")
    REFERENCES "post"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "post_save"
    ADD CONSTRAINT "post_save_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "post_save"
    ADD CONSTRAINT "post_save_fk_1"
    FOREIGN KEY("postId")
    REFERENCES "post"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "post_view"
    ADD CONSTRAINT "post_view_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "post_view"
    ADD CONSTRAINT "post_view_fk_1"
    FOREIGN KEY("postId")
    REFERENCES "post"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "quiz_answer"
    ADD CONSTRAINT "quiz_answer_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "quiz_answer"
    ADD CONSTRAINT "quiz_answer_fk_1"
    FOREIGN KEY("postId")
    REFERENCES "post"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reading_progress"
    ADD CONSTRAINT "reading_progress_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reading_progress"
    ADD CONSTRAINT "reading_progress_fk_1"
    FOREIGN KEY("bookId")
    REFERENCES "book"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "report"
    ADD CONSTRAINT "report_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "room"
    ADD CONSTRAINT "room_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "book"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "room_member"
    ADD CONSTRAINT "room_member_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_member"
    ADD CONSTRAINT "room_member_fk_1"
    FOREIGN KEY("roomId")
    REFERENCES "room"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "room_message"
    ADD CONSTRAINT "room_message_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "room"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_message"
    ADD CONSTRAINT "room_message_fk_1"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "saved_word"
    ADD CONSTRAINT "saved_word_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "study_break"
    ADD CONSTRAINT "study_break_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "topic_affinity"
    ADD CONSTRAINT "topic_affinity_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_block"
    ADD CONSTRAINT "user_block_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR limick
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('limick', '20261010002857275-limick-v1', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261010002857275-limick-v1', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260910193913364-string-rate-limit-keys', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910193913364-string-rate-limit-keys', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();


COMMIT;
