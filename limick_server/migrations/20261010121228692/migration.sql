BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reader_notification" (
    "id" bigserial PRIMARY KEY,
    "profileId" bigint NOT NULL,
    "actorName" text NOT NULL,
    "actorHandle" text NOT NULL,
    "kind" text NOT NULL,
    "postId" bigint,
    "commentId" bigint,
    "read" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "reader_notification_inbox_idx" ON "reader_notification" USING btree ("profileId", "read");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reader_notification"
    ADD CONSTRAINT "reader_notification_fk_0"
    FOREIGN KEY("profileId")
    REFERENCES "reader"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR limick
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('limick', '20261010121228692', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261010121228692', "timestamp" = now();

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
