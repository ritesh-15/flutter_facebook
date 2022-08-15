-- CreateIndex
CREATE INDEX "Session_id_userId_token_idx" ON "Session"("id", "userId", "token");

-- CreateIndex
CREATE INDEX "User_id_email_idx" ON "User"("id", "email");
