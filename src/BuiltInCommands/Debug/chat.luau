--!strict
local Services = require("../../Shared/Services")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

return {
	Name = "chat";
	Aliases = {"say"};
	Description = "Send a chat message.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "string";
			Name = "message";
			Description = "The message to send";
		};
	};

	ClientRun = function(_, message)
		if Services.TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
			local channel = Services.TextChatService:FindFirstChild("RBXGeneral")
			if channel then
				channel:SendAsync(message)
			end
		else
			local event = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
			if event then
				local sayRequest = event:FindFirstChild("SayMessageRequest")
				if sayRequest then
					sayRequest:FireServer(message, "All")
				end
			end
		end

		return ("Message sent: %s"):format(message)
	end;
}
