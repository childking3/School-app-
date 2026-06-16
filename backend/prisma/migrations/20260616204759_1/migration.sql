-- AlterTable
ALTER TABLE "Student" ADD COLUMN     "verification_status" TEXT NOT NULL DEFAULT 'pending';

-- AlterTable
ALTER TABLE "VirtualClassSession" ADD COLUMN     "class_id" TEXT;

-- CreateTable
CREATE TABLE "IdVerificationRequest" (
    "id" TEXT NOT NULL,
    "school_id" TEXT NOT NULL,
    "branch_id" TEXT,
    "student_id" TEXT NOT NULL,
    "user_id" TEXT,
    "full_name" TEXT NOT NULL,
    "document_type" TEXT NOT NULL DEFAULT 'Student ID',
    "status" TEXT NOT NULL DEFAULT 'pending',
    "notes" TEXT,
    "reviewed_by" TEXT,
    "reviewed_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "IdVerificationRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ComplianceCheck" (
    "id" TEXT NOT NULL,
    "school_id" TEXT NOT NULL,
    "branch_id" TEXT,
    "check_key" TEXT NOT NULL,
    "check_name" TEXT NOT NULL,
    "description" TEXT,
    "check_frequency" TEXT NOT NULL DEFAULT 'Daily',
    "last_result" TEXT NOT NULL DEFAULT 'Pending',
    "last_run_at" TIMESTAMP(3),
    "details" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ComplianceCheck_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GlobalForumTopic" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT,
    "author_id" TEXT,
    "author_name" TEXT,
    "author_role" TEXT DEFAULT 'teacher',
    "post_count" INTEGER NOT NULL DEFAULT 0,
    "is_locked" BOOLEAN NOT NULL DEFAULT false,
    "last_activity" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "GlobalForumTopic_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GlobalForumPost" (
    "id" TEXT NOT NULL,
    "topic_id" TEXT NOT NULL,
    "author_id" TEXT,
    "author_name" TEXT,
    "author_role" TEXT DEFAULT 'teacher',
    "content" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "GlobalForumPost_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BranchUserIdentity" (
    "id" TEXT NOT NULL,
    "school_id" TEXT NOT NULL,
    "branch_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "number" INTEGER NOT NULL,
    "school_generated_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "BranchUserIdentity_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "IdVerificationRequest_school_id_branch_id_idx" ON "IdVerificationRequest"("school_id", "branch_id");

-- CreateIndex
CREATE UNIQUE INDEX "IdVerificationRequest_school_id_student_id_key" ON "IdVerificationRequest"("school_id", "student_id");

-- CreateIndex
CREATE UNIQUE INDEX "ComplianceCheck_school_id_check_key_key" ON "ComplianceCheck"("school_id", "check_key");

-- CreateIndex
CREATE INDEX "GlobalForumTopic_last_activity_idx" ON "GlobalForumTopic"("last_activity");

-- CreateIndex
CREATE INDEX "GlobalForumPost_topic_id_idx" ON "GlobalForumPost"("topic_id");

-- CreateIndex
CREATE INDEX "BranchUserIdentity_school_id_branch_id_idx" ON "BranchUserIdentity"("school_id", "branch_id");

-- CreateIndex
CREATE UNIQUE INDEX "BranchUserIdentity_user_id_branch_id_key" ON "BranchUserIdentity"("user_id", "branch_id");

-- CreateIndex
CREATE UNIQUE INDEX "BranchUserIdentity_school_id_branch_id_role_number_key" ON "BranchUserIdentity"("school_id", "branch_id", "role", "number");
