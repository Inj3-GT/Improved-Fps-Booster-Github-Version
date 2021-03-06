------------- Script by Inj3, PROHIBITED to copy the code !
------------- GNU General Public License v3.0
------------- https://steamcommunity.com/id/Inj3/
------------- www.centralcityrp.fr/ --- Affiliated Website 
------------- https://steamcommunity.com/groups/CentralCityRoleplay --- Affiliated Group
local CentralVersion = "2.0"

util.AddNetworkString( "centralboost" )
util.AddNetworkString( "centralboostreset" )

resource.AddSingleFile("resource/fonts/seguibl.ttf")
resource.AddSingleFile("resource/fonts/seguibli.ttf")

hook.Add( "PlayerInitialSpawn", "OuvertureCentralFpsSpawn", function(ply)

timer.Simple(5, function()
if !IsValid(ply) then return end

net.Start("centralboost")
net.Send(ply)

if !ply:IsSuperAdmin() then return end
http.Fetch( "http://centralcityrp.fr/VerifyVersion", function( body, len, headers, code )
local CentralReceive = string.gsub( body, "\n", "" )

if (CentralReceive != "400: Invalid request") and (CentralReceive != "404: Not Found") and (CentralReceive != CentralVersion) then
   ply:ChatPrint( "[Only Visible for SuperAdmin] Deprecated Version of Improved Fps Booster, Version : " ..CentralVersion.. " , download the latest version on Github or Workshop, Version : " ..CentralReceive )
end

end,

function( error )
print("Improved Fps booster HTTTP (error) : " , error)
end)

end)

end)

local function Central_FpsRemoveConvarDisco(ply)

   for i = 1, #CentralTableIFB.CentralFPSbooster_DResetConC do
      ply:ConCommand(CentralTableIFB.CentralFPSbooster_DResetConC[i]["CentralFPSbooster_ConCom"])
   end
   
end
hook.Add("PlayerDisconnected","Central_FpsRemoveConvarDisco", Central_FpsRemoveConvarDisco)

hook.Add("Initialize","CentralFpsRemoveHook",function()

if timer.Exists("HostnameThink") then
   timer.Remove("HostnameThink")
end

if timer.Exists("CheckHookTimes") then
   timer.Remove("CheckHookTimes")
end

hook.Remove("Think", "CheckSchedules")
hook.Remove("PlayerTick", "TickWidgets")
end)

hook.Add("PlayerSay", "CentralFpsChatCmd", function(ply, text)

if ( string.sub( string.lower( text ), 1, 7 ) == "/boost" )  then
   net.Start("centralboost")
   net.Send(ply)
   return ""
   
elseif ( string.sub( string.lower( text ), 1, 7 ) == "/reset" ) then
   net.Start("centralboostreset")
   net.Send(ply)
   return ""
end

end)

MsgC( Color( 0, 250, 0 ), "Improved FPS Booster loaded.\n" )