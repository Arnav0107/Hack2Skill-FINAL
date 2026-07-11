-- AlterTable
ALTER TABLE "scores" ADD COLUMN "explanation_json" TEXT;

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_msme_profiles" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "user_id" TEXT NOT NULL,
    "business_name" TEXT NOT NULL,
    "gstin" TEXT,
    "sector" TEXT,
    "registration_type" TEXT,
    "region" TEXT,
    "employee_band" TEXT,
    "registered_on" DATETIME,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "promoter_credit_score" INTEGER NOT NULL DEFAULT 650,
    "commercial_assets_value" REAL NOT NULL DEFAULT 0,
    "bank_asset_value" REAL NOT NULL DEFAULT 0,
    "aa_linked_accounts_count" INTEGER NOT NULL DEFAULT 1,
    "registration_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "msme_profiles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_msme_profiles" ("business_name", "created_at", "employee_band", "gstin", "id", "region", "registered_on", "sector", "user_id") SELECT "business_name", "created_at", "employee_band", "gstin", "id", "region", "registered_on", "sector", "user_id" FROM "msme_profiles";
DROP TABLE "msme_profiles";
ALTER TABLE "new_msme_profiles" RENAME TO "msme_profiles";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
