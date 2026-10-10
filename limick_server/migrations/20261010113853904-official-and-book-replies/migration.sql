BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "comment" ADD COLUMN "asBookId" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "official_post" (
    "id" bigserial PRIMARY KEY,
    "kind" text NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "bookId" bigint,
    "postId" bigint,
    "action" text,
    "actionLabel" text,
    "position" bigint NOT NULL DEFAULT 0,
    "day" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "official_post_day_idx" ON "official_post" USING btree ("kind", "day");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "official_seen" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "officialPostId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "official_seen_unique_idx" ON "official_seen" USING btree ("profileId", "officialPostId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "reader" ADD COLUMN "official" boolean NOT NULL DEFAULT false;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "official_seen"
    ADD CONSTRAINT "official_seen_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "official_seen"
    ADD CONSTRAINT "official_seen_fk_1"
    FOREIGN KEY("officialPostId")
    REFERENCES "official_post"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR limick
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('limick', '20261010113853904-official-and-book-replies', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261010113853904-official-and-book-replies', "timestamp" = now();

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
