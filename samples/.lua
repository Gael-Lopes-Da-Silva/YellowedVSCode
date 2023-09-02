-- NB: First run the corresponding "INIT" script as a global script, then this one per-entry.
-- TOOLS / LUA ENTRY SCRIPT (NB, run on carefully filtered subset only)
-- dj2021-04
-- @returns test

-- If we've hit limit of how many to do, stop
if (TOTALNUMDONE>MAXTODO) then return ""; end

-- once-off loadall on first entry we process
if LOADED==0 then
	tRequestLoadAll();--Make sure have loaded all entries if on ODBC
	LOADED = 1;
end

-- Make sure we don't change timestamps and lastmodifiedby etc. [this is a new thing 2019-04, may change, API-unstable]
g_bAdminNoUpdateTimestamps=true;--API-unstable

-- Make sure we have a document open
local DOC = tApp():GetCurrentDoc();
if DOC == nil then
	return "No document open";
end

--tRequestLoadAll();--Make sure have loaded all entries if on ODBC

local ENTRY=gCurrentEntry;

--collectgarbage(0);
collectgarbage("collect")
tRequestLoadSafe(ENTRY);

-- Find all instances of the desired element we want to modify
local aNODES=vector_tcNode__:new_local();
ENTRY:FindDescendantsOfElementType(ELEM1:GetID(),aNODES);
if (aNODES:size()>0) then
	local bTHISCHANGED=false;
	for k=0,aNODES:size()-1,1 do
		local NODE=aNODES[k];

		-- Must be simple single text child case
		if (NODE:GetNumChildren()==1) and
			NODE:GetChild(0):IsKindOfClass(NODE_TEXTNODE)
		then
			local s=tQuery(NODE,'/');
			-- Check if text is any of the values we want to convert to attribute
			if s=='s.nw.'
			or s=='ww.'
			or s=='b.nw.'
			or s=='bw.'
			or s=='telw.'
			or s=='tw.'
			or s=='vnw.'
			or s=='voegw.'
			or s=='voors.'
			or s=='aanvangskomponent van byv. komposita'
			or s=='aanvangskomponent van selfst. komposita'
			or s=='aanvangskomponent van ww. komposita'
			or s=='slotkomponent van selfst. komposita'
			or s=='gespesialiseerde uitdr.'
			or s=='idiomatiese uitdr.'
			or s=='afk.'
			or s=='groepvoorsetsel'
			or s=='leenwoordgroep'
			or s=='naamwoordgroep'
			or s=='simbool'
			then
				if (tRequestModify(ENTRY,true)==true) then
					NODE:SetAttributeDisplayByString(ATTR,s);--Set attribute instead
					DOC:DeleteTreeFromDoc(NODE:GetChild(0));--Delete old text child
					bTHISCHANGED=true;
				end
			end
		end
	end

	if (bTHISCHANGED) then
		-- Mark as changed (without updating timestamp)
		ENTRY:SetChanged(true,false);

		TOTALNUMDONE=TOTALNUMDONE+1
		CHANGED=CHANGED+1;
		if (CHANGED>=SAVEAFTER) then
			--tcSleep:Sleep(1);
			tFrameWindow():Save();
			--tcSleep:Sleep(1);
			if SECONDSSLEEPAFTERSAVE>0 then tcSleep:Sleep(SECONDSSLEEPAFTERSAVE); end
			CHANGED=0;
		end
	end
end

-- TOOLS / LUA SCRIPT (NB, run on carefully filtered subset only)
-- TLex script to help convert Woordsoort text child to a list attribute in TLex
-- To use, first once-off run the INIT script via Tools / Exec Lua Script (which sets up some global variables used by the ENTRY script)
-- then right-click entry list and for all entries run the 'Lua ENTRY script'
-- dj2021-04

--tRequestLoadAll();
CHANGED=0;
MAXTODO=20000000;
TOTALNUMDONE=0;
SAVEAFTER=40;--Save after every N entries changed with ODBC (can set this to very high value for local dry run testing or .tldict file)
SECONDSSLEEPAFTERSAVE=0;--Sleep between saves? If running 'heavy' script on live server to minimize impact on other users
-- Uncomment for local dry-run test:
--MAXTODO=200000000;
--SAVEAFTER=400000000;
--SECONDSSLEEPAFTERSAVE=0;

-- Make sure we don't change timestamps and lastmodifiedby etc. [this is a new thing 2019-04, may change, API-unstable]
g_bAdminNoUpdateTimestamps=true;--API-unstable

-- Make sure we have a document open
local DOC = tApp():GetCurrentDoc();
if DOC == nil then
	return "No document open";
end

ELEM1=DOC:GetDTD():FindElementByName("Woordsoort");
if ELEM1==nil then return "No desired element";end
ATTR=ELEM1:FindAttributeByName("Woordsoort");
if ATTR==nil then return "No desired attribute";end

LOADED=0;
tRequestLoadAll();

--- Define special sequences of characters.
-- For each pair (find, subs), the function will create a field named with
-- find which has the value of subs.
-- It also creates an index for the table, according to the order of insertion.
-- @param subs The replacement pattern.
-- @param find The pattern to find.
function def_escapes (find, subs)
   local special = { t = "\t", n = "\n", ['"'] = '"', ['\\'] = '\\', }
   find = gsub (find, "\\(.)", function (x) return %special[x] or x end)
   subs = gsub (subs, "\\(.)", function (x) return %special[x] or x end)
   escape_sequences.n = escape_sequences.n+1
   escape_sequences[escape_sequences.n] = find
   escape_sequences[find] = subs
end