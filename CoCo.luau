--!nocheck
--!nolint

--[[
    @panduhpanduhpanduhpanduh on Discord
    https://github.com/Panda-Utilities/CoCo/

    This file was automatically generated with darklua, it is not intended for manual editing.
--]]

_P = {
    genDate = "2026-06-01T22:44:09.093761420+00:00",
    cfg = "Release",
    vers = "0.1.0"
}

local a={cache={}}do do local b=function()local b=cloneref or function(b)return
b end local c={UserInputService=b(game:GetService'UserInputService'),RunService=
b(game:GetService'RunService'),GuiService=b(game:GetService'GuiService'),Players
=b(game:GetService'Players'),Teams=b(game:GetService'Teams'),TextChatService=b(
game:GetService'TextChatService'),TextService=b(game:GetService'TextService'),
HttpService=b(game:GetService'HttpService'),StarterGui=b(game:GetService
'StarterGui'),CoreGui=b(game:GetService'CoreGui'),Lighting=b(game:GetService
'Lighting'),TweenService=b(game:GetService'TweenService'),Workspace=b(game:
GetService'Workspace'),PathfindingService=b(game:GetService'PathfindingService')
}return c end function a.a()local c=a.cache.a if not c then c={c=b()}a.cache.a=c
end return c.c end end do local b=function()local b,c,d,e,f,g,h=function(b,c)
local d={}for e,f in ipairs(b)do local g=c(f,e,b)if g~=nil then table.insert(d,g
)end end return d end,function(b,c)local d={}c=if type(c)=='function'then c else
function(e)return e end for e,f in ipairs(b)do if c(f,e,b)then table.insert(d,f)
end end return d end,function(b,c,d)local e=d for f,g in ipairs(b)do e=c(e,g,f)
end return e end,function(b,c)for d,e in ipairs(b)do if c(e,d)then return e end
end return nil end,function(b,c)for d,e in ipairs(b)do if c(e,d)then return true
end end return false end,function(...)local b={}for c=1,select('#',...)do local
d=select(c,...)for e,f in d do b[e]=f end end return b end,function(b)local c={}
for d in b do table.insert(c,d)end return c end local i={Array={map=b,filter=c,
reduce=d,find=e,some=f},Dictionary={merge=g,keys=h}}i.List=i.Array return i end
function a.b()local c=a.cache.b if not c then c={c=b()}a.cache.b=c end return c.
c end end do local b=function()local b,c,d={},function(b)return b:gsub(
'[%^%$%(%)%%%.%[%]%*%+%-%?]','%%%1')end,function(b)return utf8.char(tonumber(b,
16))end function b.splitStringSimple(e,f)if f==nil then f='%s'end if f:sub(1,1)
~='%'then f=f:gsub('[%^%$%(%)%%%.%[%]%*%+%-%?]','%%%1')end local g,h={},1 for i
in string.gmatch(e,'([^'..f..']+)')do g[h]=i h=h+1 end return g end function b.
parseEscapeSequences(e)return e:gsub('\\(.)',{t='\t',n='\n'}):gsub(
'\\u(%x%x%x%x)',d):gsub('\\x(%x%x)',d)end function b.encodeEscapedOperator(e,f)
local g,h=f:gsub('.',function(g)return'%'..g end),c(f:sub(1,1))return e:gsub('('
..h..'+)('..g..')',function(i,j)return(i:sub(1,#i-1)..j):gsub('.',function(k)
return'\\u'..string.format('%04x',string.byte(k),16)end)end)end local e={'&&',
'||',';'}function b.encodeEscapedOperators(f)for g,h in ipairs(e)do f=b.
encodeEscapedOperator(f,h)end return f end function b.splitString(f,g)g=g or
math.huge local h,i,j,k,l={},{},false,1 while k<=#f do local m=f:sub(k,k)if m==
'\\'then local n=f:sub(k+1,k+1)if n=='\n'or n=='n'then table.insert(i,'\n')k=k+2
elseif n=='t'then table.insert(i,'\t')k=k+2 elseif n=='u'then local o=f:sub(k+2,
k+5)if#o==4 and o:match'^%x%x%x%x$'then table.insert(i,utf8.char(tonumber(o,16))
)k=k+6 else table.insert(i,m)k=k+1 end elseif n=='x'then local o=f:sub(k+2,k+3)
if#o==2 and o:match'^%x%x$'then table.insert(i,utf8.char(tonumber(o,16)))k=k+4
else table.insert(i,m)k=k+1 end elseif n~=nil then table.insert(i,n)k=k+2 else
table.insert(i,m)k=k+1 end elseif m=='"'or m=="'"then if not j then j=true l=m
elseif m==l then j=false else table.insert(i,m)end k=k+1 elseif m==' 'then if j
then table.insert(i,m)else if#i>0 then local n=table.concat(i)if#h<g then h[#h+1
]=n else h[g]=h[g]..' '..n end i={}end end k=k+1 else table.insert(i,m)k=k+1 end
end if#i>0 then h[#h+1]=table.concat(i)end return h end function b.
mashExcessArguments(f,g)local h={}for i=1,#f do if i>g then h[g]=`{h[g]or''} {f[
i]}`else h[i]=f[i]end end return h end function b.trimString(f)local g,h=string.
find(f,'^%s*')return h==#f and''or string.match(f,'.*%S',h+1)end function b.
emulateTabstops(f,g)local h,i=0,#f local j=table.create(i)for k=1,i do local l=
string.sub(f,k,k)if l=='\t'then local m=g-h%g table.insert(j,string.rep(' ',m))h
+=m else table.insert(j,l)if l=='\n'then h=0 elseif l~='\r'then h+=1 end end end
return table.concat(j)end return b end function a.c()local c=a.cache.c if not c
then c={c=b()}a.cache.c=c end return c.c end end do local b=function()local b,c,
d=a.b(),a.c(),{}function d.makeDictionary(e)local f={}for g=1,#e do f[e[g] ]=
true end return f end function d.makeListableType(e,f)local g={Listable=true,
Transform=e.Transform,Validate=e.Validate,ValidateOnce=e.ValidateOnce,
Autocomplete=e.Autocomplete,Default=e.Default,ArgumentOperatorAliases=e.
ArgumentOperatorAliases,Selectors=e.Selectors,Parse=function(...)return{e.Parse(
...)}end}if f then for h,i in pairs(f)do g[h]=i end end return g end function d.
splitPrioritizedDelimeter(e,f)for g,h in ipairs(f)do if e:find(h)or g==#f then
return c.splitStringSimple(e,h)end end end function d.parsePrefixedUnionType(e,f
)local g,h=c.splitStringSimple(e),{}for i=1,#g,2 do h[#h+1]={prefix=g[i-1]or'',
type=g[i]}end table.sort(h,function(i,j)return#i.prefix>#j.prefix end)for i=1,#h
do local j=h[i]if f:sub(1,#j.prefix)==j.prefix then return j.type,f:sub(#j.
prefix+1),j.prefix end end end function d.makeSequenceType(e)e=e or{}if e.Parse
==nil and e.Constructor==nil then error
'MakeSequenceType: Must provide one of: Constructor, Parse'end e.TransformEach=e
.TransformEach or function(...)return...end e.ValidateEach=e.ValidateEach or
function()return true end return{Prefixes=e.Prefixes,Transform=function(f)return
b.List.map(d.splitPrioritizedDelimeter(f,{',','%s'}),function(g)return e.
TransformEach(g)end)end,Validate=function(f)if e.Length and#f>e.Length then
return false,('Maximum of %d values allowed in sequence'):format(e.Length)end
for g=1,e.Length or#f do local h,i=e.ValidateEach(f[g],g)if not h then return
false,i end end return true end,Parse=e.Parse or function(f)return e.
Constructor(unpack(f))end}end return d end function a.d()local c=a.cache.d if
not c then c={c=b()}a.cache.d=c end return c.c end end do local b=function()
local b,c=a.d(),a.b()local d={TypeMethods=b.makeDictionary{'Transform',
'Validate','Autocomplete','Parse','DisplayName','Listable','ValidateOnce',
'Prefixes','Default','Debounce','ArgumentOperatorAliases','Selectors'},
CommandMethods=b.makeDictionary{'Name','Aliases','InverseAliases','AutoExec',
'Description','Args','Run','ClientRun','Data','Group'},CommandArgProps=b.
makeDictionary{'Name','Type','Description','Optional','Default'},Types={},
TypeAliases={},Commands={},CommandsArray={},InvertedCommands={},Hooks={BeforeRun
={},AfterRun={}},Stores=setmetatable({},{__index=function(d,e)d[e]={}return d[e]
end})}function d:registerType(e,f)if not e or typeof(e)~='string'then error
'Invalid type name provided: nil'end if not e:find'^[%d%l]%w*$'then error(`Invalid type name provided: "{
e}", type names must be alphanumeric and start with a lower-case letter or a digit.`
)end for g in pairs(f)do if self.TypeMethods[g]==nil then error(`Unknown key/method in type "{
e}": {g}`)end end if self.Types[e]~=nil then error(`Type "{e}" has already been registered.`
)end f.Name=e f.DisplayName=f.DisplayName or e self.Types[e]=f if f.Prefixes
then self:registerTypePrefix(e,f.Prefixes)end end function d:registerTypePrefix(
e,f)if not self.TypeAliases[e]then self.TypeAliases[e]=e end self.TypeAliases[e]
=`{self.TypeAliases[e]} {f}`end function d:registerTypeAlias(e,f)if self.
TypeAliases[e]~=nil then error(`Type alias {f} already exists!`)end self.
TypeAliases[e]=f end function d:registerCommandObject(e)for f in pairs(e)do if
self.CommandMethods[f]==nil then error(`Unknown key/method in command {e.Name or
'unknown command'}: {f}`)end end if e.Args then for f,g in ipairs(e.Args)do if
type(g)=='table'then for h in pairs(g)do if self.CommandArgProps[h]==nil then
error(`Unknown property in command "{e.Name or'unknown'}" argument #{f}: {h}`)
end end end end end local f=self.Commands[e.Name:lower()]if f and f.Aliases then
for g,h in ipairs(f.Aliases)do self.Commands[h:lower()]=nil end if f.
InverseAliases then for g,h in ipairs(f.InverseAliases)do self.Commands[h:lower(
)]=nil self.InvertedCommands[h:lower()]=nil end end elseif not f then table.
insert(self.CommandsArray,e)end self.Commands[e.Name:lower()]=e if e.Aliases
then for g,h in ipairs(e.Aliases)do self.Commands[h:lower()]=e end end if e.
InverseAliases then for g,h in ipairs(e.InverseAliases)do self.Commands[h:lower(
)]=e self.InvertedCommands[h:lower()]=true end end end function d:getCommand(e)e
=e or''return self.Commands[e:lower()]end function d:isInvertedCommand(e)return
self.InvertedCommands[e:lower()]==true end function d:getCommands()return self.
CommandsArray end function d:getCommandNames()local e={}for f,g in ipairs(self.
CommandsArray)do table.insert(e,g.Name)if g.Aliases then for h,i in ipairs(g.
Aliases)do table.insert(e,i)end end if g.InverseAliases then for h,i in ipairs(g
.InverseAliases)do table.insert(e,i)end end end return e end function d:
getTypeNames()return c.Dictionary.keys(self.Types)end function d:getType(e)
return self.Types[e]end function d:getTypeName(e)return self.TypeAliases[e]or e
end function d:registerHook(e,f,g)if not self.Hooks[e]then error(`Invalid hook name: {
e}`,2)end table.insert(self.Hooks[e],{callback=f,priority=g or 0})table.sort(
self.Hooks[e],function(h,i)return h.priority<i.priority end)end function d:
getStore(e)return self.Stores[e]end return function(e)return d end end function
a.e()local c=a.cache.e if not c then c={c=b()}a.cache.e=c end return c.c end end
do local b=function()local b,c,d,e=a.a().Players,function(b,c)for d in pairs(c)
do b[d]=true end return b end,function(b,c)local d={}for e in pairs(b)do if c[e]
then d[e]=true end end return d end,function(b,c)local d={}for e in pairs(b)do d
[e]=true end for e in pairs(c)do d[e]=nil end return d end local f=function(f)
local g={}for h,i in ipairs(b:GetPlayers())do if not f[i.Name]then g[i.Name]=
true end end return g end return{union=c,intersection=d,difference=e,complement=
f}end function a.f()local c=a.cache.f if not c then c={c=b()}a.cache.f=c end
return c.c end end do local b=function()local b={GuiRoot=nil,Colors={
BackgroundDark=Color3.fromRGB(17,17,17),BackgroundMedium=Color3.fromRGB(59,59,59
),BackgroundLight=Color3.fromRGB(230,230,230),TextPrimary=Color3.fromRGB(255,255
,255),TextAccent=Color3.fromRGB(255,223,93),TextHighlight=Color3.fromRGB(230,126
,34),TextSecondary=Color3.fromRGB(131,222,255),AutocompleteItem=Color3.fromRGB(
131,222,255),HelpOrange=Color3.fromRGB(230,126,34),HelpGray=Color3.fromRGB(230,
230,230),Stroke=Color3.fromRGB(30,30,30)},Gui={HistoryFile='coco_history.txt',
DefaultTextSize=14,ScrollBarThickness=6,EntryLayoutOrder=999999999,
BackgroundTransparency=0.4,AutocompleteBackgroundTransparency=0.5,
SectionBackgroundTransparency=0.2,DefaultPadding=10},Argument={
KeywordResolverMaxDepth=20}}return b end function a.g()local c=a.cache.g if not
c then c={c=b()}a.cache.g=c end return c.c end end do local b=function()local b,
c,d,e,f,g=a.c(),a.d(),a.f(),a.g(),function(b)for c,d in ipairs{'%.','%?','%*',
'%*%*'}do b=b:gsub('\\'..d,d:gsub('%%',''))end return b end,{}g.__index=g
function g.new(h,i,j,k)local l={Registry=h,Command=i,Type=nil,Name=j.Name,Object
=j,Required=j.Default==nil and j.Optional~=true,Executor=i.Executor,RawValue=k,
RawSegments={},TransformedValues={},Prefix='',TextSegmentInProgress='',
RawSegmentsAreAutocomplete=false}if type(j.Type)=='table'then l.Type=j.Type else
local m,n,o=c.parsePrefixedUnionType(h:getTypeName(j.Type),k)l.Type=h:getType(m)
l.RawValue=n l.Prefix=o if l.Type==nil then error(string.format(
'%s has an unregistered type %q',l.Name or'<none>',m or'<none>'))end end
setmetatable(l,g)l:Transform()return l end function g:GetDefaultAutocomplete()if
self.Type.Autocomplete then local h,i=self.Type.Autocomplete(self:
TransformSegment'',self)return h,i or{}end return{}end function g:Transform()if#
self.TransformedValues~=0 then return end local h=self.RawValue if self.Type.
ArgumentOperatorAliases then h=self.Type.ArgumentOperatorAliases[h]or h end if h
=='.'and self.Type.Default then h=self.Type.Default(self.Executor)or''self.
RawSegmentsAreAutocomplete=true end if h=='?'and self.Type.Autocomplete then
local i,j=self:GetDefaultAutocomplete()if not j.IsPartial and#i>0 then h=i[math.
random(1,#i)]self.RawSegmentsAreAutocomplete=true end end if self.Type.Selectors
and not self.RawSegmentsAreAutocomplete and self.Executor then local i=self:
resolveSelectorValue(h)if i then if self.Type.Listable then h=i self.
RawSegmentsAreAutocomplete=true else local j=b.splitStringSimple(i,',')if#j>0
then h=j[1]end end end end if not self.RawSegmentsAreAutocomplete and#self.
RawValue>0 then if h=='*'or h=='**'then local i,j=self:GetDefaultAutocomplete()
if not j.IsPartial and#i>0 then if h=='**'and self.Type.Default then local k,l=
self.Type.Default(self.Executor)or'',{}for m,n in ipairs(i)do if n~=k then table
.insert(l,n)end end i=l end if self.Type.Listable then h=table.concat(i,',')self
.RawSegmentsAreAutocomplete=true elseif#i>0 then h=i[1]end end end end if self.
Type.Listable and#self.RawValue>0 then local i=h:match'^%?(%d+)$'if i then local
j=tonumber(i)if j and j>0 then local k,l,m={},self:GetDefaultAutocomplete()if
not m.IsPartial and#l>0 then local n={}for o=1,#l do n[o]=o end for o=1,math.
min(j,#l)do local p=math.random(1,#n)table.insert(k,l[table.remove(n,p)])end h=
table.concat(k,',')self.RawSegmentsAreAutocomplete=true end end end h=f(h)local
j=b.splitStringSimple(h,',')if#j==0 then j={''}end if h:sub(#h,#h)==','then j[#j
+1]=''end for k,l in ipairs(j)do self.RawSegments[k]=l self.TransformedValues[k]
={self:TransformSegment(l)}end self.TextSegmentInProgress=j[#j]else h=f(h)self.
RawSegments[1]=f(h)self.TransformedValues[1]={self:TransformSegment(h)}self.
TextSegmentInProgress=self.RawValue end end function g:TransformSegment(h)if
self.Type.Transform then return self.Type.Transform(h,self.Executor)else return
h end end function g:GetTransformedValue(h)return unpack(self.TransformedValues[
h])end function g:Validate(h)if self.RawValue==nil or#self.RawValue==0 and self.
Required==false then return true end if self.Required and(self.RawSegments[1]==
nil or#self.RawSegments[1]==0)then return false,'This argument is required.'end
if self.Type.Validate or self.Type.ValidateOnce then for i=1,#self.
TransformedValues do if self.Type.Validate then local j,k=self.Type.Validate(
self:GetTransformedValue(i))if not j then return j,k or'Invalid value'end end if
h and self.Type.ValidateOnce then local j,k=self.Type.ValidateOnce(self:
GetTransformedValue(i))if not j then return j,k end end end return true else
return true end end function g:GetAutocomplete()if self.Type.Autocomplete then
return self.Type.Autocomplete(self:GetTransformedValue(#self.TransformedValues),
self)else return{}end end function g:ParseValue(h)if self.Type.Parse then return
self.Type.Parse(self:GetTransformedValue(h))else return self:
GetTransformedValue(h)end end function g:GetValue()if#self.RawValue==0 and not
self.Required and self.Object.Default~=nil then return self.Object.Default end
if not self.Type.Listable then return self:ParseValue(1)end local h={}for i=1,#
self.TransformedValues do local j=self:ParseValue(i)if type(j)~='table'then
error(`Listable types must return a table from Parse ({self.Type.Name})`)end for
k,l in ipairs(j)do h[l]=true end end local i={}for j in pairs(h)do i[#i+1]=j end
return i end function g:resolveKeywordResolver(h)if not self.Type.Selectors or
not self.Type.Selectors.Keyword then return nil end local i,j={},h for k=1,e.
Argument.KeywordResolverMaxDepth do if i[j]then return nil end i[j]=true local l
=self.Type.Selectors.Keyword[j]if l==nil then return nil end if type(l)==
'function'then return l end j=l end return nil end function g:
resolveSelectorTerm(h,i)if#h==0 then return{}end local j=self:
resolveKeywordResolver(h)if j then local k,l=j(self.Executor),{}for m,n in
ipairs(k)do l[n]=true end if i then return d.complement(l)end return l end for k
,l in ipairs(self.Type.Selectors.Pattern or{})do local m={h:match(l.Pattern)}if#
m>0 then local n=i and l.Invert or l.Resolve if n then local o,p=n(self.Executor
,m),{}for q,r in ipairs(o)do p[r]=true end return p end end end local k,l=self:
TransformSegment(h),{}for m,n in ipairs(k)do l[n.Name]=true end if i then return
d.complement(l)end return l end function g:parseCompoundTerms(h)local i,j,k={},1
,#h while j<=k do local l if#i>0 then local m=h:sub(j,j)if m=='+'then l='+'j+=1
elseif m=='-'then l='-'j+=1 else break end end local m,n=false,h:sub(j,j)if n==
'-'then m=true j+=1 elseif n=='+'then j+=1 end local o=''while j<=k do local p=h
:sub(j,j)if p=='+'or p=='-'then break end o=o..p j+=1 end if#o>0 then table.
insert(i,{operator=l,term=o,negated=m})end end return i end function g:
resolveCompoundExpression(h)local i=self:parseCompoundTerms(h)if#i==0 then
return{}end local j=self:resolveSelectorTerm(i[1].term,i[1].negated)for k=2,#i
do local l=i[k]local m=self:resolveSelectorTerm(l.term,l.negated)if l.operator==
'+'then j=d.intersection(j,m)else j=d.difference(j,m)end end return j end
function g:hasSelectorContent(h)if not self.Type.Selectors then return false end
if h:match'[%+%-]'then return true end local i=b.splitStringSimple(h,',')for j,k
in ipairs(i)do for l in pairs(self.Type.Selectors.Keyword)do if type(l)==
'string'and k==l then return true end end for l,m in ipairs(self.Type.Selectors.
Pattern or{})do if k:match(m.Pattern)then return true end end end return false
end function g:resolveSelectorValue(h)if not self:hasSelectorContent(h)then
return nil end local i,j=b.splitStringSimple(h,','),{}for k,l in ipairs(i)do
local m=self:resolveCompoundExpression(l)if next(m)then j=d.union(j,m)end end
local k={}for l in pairs(j)do table.insert(k,l)end if#k==0 then return nil end
return table.concat(k,',')end return g end function a.h()local c=a.cache.h if
not c then c={c=b()}a.cache.h=c end return c.c end end do local b=function()
local b,c=a.h(),{}c.__index=c function c.new(d)local e={Dispatcher=d.Dispatcher,
CoCo=d.Dispatcher.CoCo,Name=d.CommandObject.Name,RawText=d.Text,Object=d.
CommandObject,Group=d.CommandObject.Group,State={},Aliases=d.CommandObject.
Aliases,Alias=d.Alias,Description=d.CommandObject.Description,Executor=d.
Executor,ArgumentDefinitions=d.CommandObject.Args,RawArguments=d.Arguments,
Arguments={},Data=d.Data,Response=nil}setmetatable(e,c)return e end function c:
parse(d)local e=false for f,g in ipairs(self.ArgumentDefinitions)do if type(g)==
'function'then g=g(self)if g==nil then break end end local h=(g.Default==nil and
g.Optional~=true)if h and e then error(`Command {self.Name:format'%q'}: Required arguments cannot occur after optional arguments.`
)elseif not h then e=true end if self.RawArguments[f]==nil and h and d~=true
then return false,`Required argument #{f} {g.Name} is missing.`elseif self.
RawArguments[f]or d then self.Arguments[f]=b.new(self.Dispatcher.Registry,self,g
,self.RawArguments[f]or'')end end return true end function c:validate(d)self.
_Validated=true local e,f='',true for g,h in ipairs(self.Arguments)do local i,j=
h:Validate(d)if not i then f=false e=`{e}; #{g} {h.Name}: {j or'error'}`end end
return f,e:sub(3)end function c:getLastArgument()for d=#self.Arguments,1,-1 do
if self.Arguments[d].RawValue then return self.Arguments[d]end end end function
c:gatherArgumentValues()local d={}for e=1,#self.ArgumentDefinitions do local f=
self.Arguments[e]if f then d[e]=f:GetValue()elseif type(self.ArgumentDefinitions
[e])=='table'then d[e]=self.ArgumentDefinitions[e].Default end end return d,#
self.ArgumentDefinitions end function c:run()if self._Validated==nil then error
'Must validate a command before running.'end local d=self.Dispatcher:runHooks(
'BeforeRun',self)if d then return d end if self.Object.Run then local e,f=self:
gatherArgumentValues()self.Response=self.Object.Run(self,unpack(e,1,f))elseif
self.Object.ClientRun then local e,f=self:gatherArgumentValues()self.Response=
self.Object.ClientRun(self,unpack(e,1,f))else warn(self.Name,
'command has no implementation!')self.Response='No implementation.'end local e=
self.Dispatcher:runHooks('AfterRun',self)if e then return e else return self.
Response end end function c:getArgument(d)return self.Arguments[d]end function c
:isInvertedCall()return self.Dispatcher.Registry:isInvertedCommand(self.Alias)
end function c:reply(d,e)self.Dispatcher.CoCo.Events.AddLine:Fire(d,e)end
function c:getStore(...)return self.Dispatcher.CoCo.Registry:getStore(...)end
return c end function a.i()local c=a.cache.i if not c then c={c=b()}a.cache.i=c
end return c.c end end do local b=function()local b,c,d=a.c(),a.i(),a.g()local e
,f=d.Gui.HistoryFile,{CoCo=nil,Registry=nil}function f:evaluate(g,h,i,j)local k=
b.splitString(g)local l=table.remove(k,1)local m=self.Registry:getCommand(l)if m
then k=b.mashExcessArguments(k,#m.Args)local n=c.new{Dispatcher=self,Text=g,
CommandObject=m,Alias=l,Executor=h,Arguments=k,Data=j}local o,p=n:parse(i)if o
then return n else return false,p end else return false,(`%q is not a valid command name. Use the help command to see all available commands.`
):format(tostring(l))end end function f:evaluateAndRun(g,h)h=h or self.
_defaultExecutor if h then self:pushHistory(g)end local i,j=self:evaluate(g,h)if
not i then return j end local k,l=xpcall(function()local k,l=i:validate(true)if
not k then return l end return i:run()or'Command executed.'end,function(k)return
debug.traceback(tostring(k))end)if not k then warn(`Error occurred while evaluating command string {
g:format'%q'}\n{tostring(l)}`)end return k and l or
'An error occurred while running this command.'end function f:run(...)local g={
...}local h,i=g[1],{}for j=2,#g do i[#i+1]=tostring(g[j])end if#i>0 then h=h..
' '..table.concat(i,' ')end local j,k=self:evaluate(h,self._defaultExecutor)if
not j then error(k)end local l,m=j:validate(true)if not l then error(m)end
return j:run()end function f:runHooks(g,h,...)if not self.Registry.Hooks[g]then
error(`Invalid hook name: {g:format'%q'}`,2)end for i,j in ipairs(self.Registry.
Hooks[g])do local l=j.callback(h,...)if l~=nil then return tostring(l)end end
end function f:pushHistory(g)if b.trimString(g)==''then return end local h=self:
getHistory()if g==h[#h]then return end h[#h+1]=g local i=pcall(writefile,e,table
.concat(h,'\n'))if not i then warn('CoCo: Failed to write command history to '..
e)end end function f:getHistory()local g,h=pcall(readfile,e)if g and h then
local i={}for j in h:gmatch'[^\r\n]+'do table.insert(i,j)end return i end return
{}end return function(g,h)f.CoCo=g f.Registry=g.Registry f._defaultExecutor=h
return f end end function a.j()local c=a.cache.j if not c then c={c=b()}a.cache.
j=c end return c.c end end do local b=function()local b=function(b,c,d)local e=
Instance.new(b)for f,g in pairs(c)do e[f]=g end if d then for f,g in ipairs(d)do
g.Parent=e end end return e end return b end function a.k()local c=a.cache.k if
not c then c={c=b()}a.cache.k=c end return c.c end end do local b=function()
local b,c,d=a.k(),a.g(),function()local b,c=pcall(gethui)if b then return c end
return a.a().CoreGui end local e,f,g,h,i,j=function(e)e=e or{}return b(
'ScrollingFrame',{BackgroundColor3=e.BackgroundColor3 or c.Colors.BackgroundDark
,BackgroundTransparency=e.BackgroundTransparency or c.Gui.BackgroundTransparency
,BorderSizePixel=0,CanvasSize=e.CanvasSize or UDim2.new(0,0,0,0),Position=e.
Position or UDim2.new(0.025,0,0,25),ScrollBarThickness=e.ScrollBarThickness or c
.Gui.ScrollBarThickness,ScrollingDirection=e.ScrollingDirection or Enum.
ScrollingDirection.Y,Selectable=false,Size=e.Size or UDim2.new(0.95,0,0,0),
Visible=e.Visible~=nil and e.Visible or false,AutomaticCanvasSize=e.
AutomaticCanvasSize or Enum.AutomaticSize.Y,Name=e.Name or''},e.Children)end,
function(e)return b('UIPadding',{PaddingBottom=UDim.new(0,e and e.bottom or 10),
PaddingLeft=UDim.new(0,e and e.left or 10),PaddingRight=UDim.new(0,e and e.right
or 10),PaddingTop=UDim.new(0,e and e.top or 10)})end,function(e)return b(
'UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,FillDirection=e or Enum.
FillDirection.Vertical,Padding=e==Enum.FillDirection.Horizontal and UDim.new(0,7
)or nil})end,function(e)e=e or{}return b('TextLabel',{BackgroundTransparency=1,
Font=e.Font or Enum.Font.Code,Text=e.Text or'',TextColor3=e.TextColor3 or c.
Colors.TextPrimary,TextSize=e.TextSize or c.Gui.DefaultTextSize,TextXAlignment=e
.TextXAlignment or Enum.TextXAlignment.Left,TextYAlignment=e.TextYAlignment or
Enum.TextYAlignment.Center,Size=e.Size or UDim2.new(1,0,0,20),AutomaticSize=e.
AutomaticSize or Enum.AutomaticSize.None,TextWrapped=e.TextWrapped or false,Name
=e.Name or'TextLabel'},e.Children)end,function(e)e=e or{}return b('TextBox',{
BackgroundTransparency=1,ClearTextOnFocus=false,Font=Enum.Font.Code,
PlaceholderText=e.PlaceholderText or'',Position=e.Position or UDim2.new(0,0,0,0)
,Size=e.Size or UDim2.new(1,0,0,20),TextColor3=e.TextColor3 or c.Colors.
TextPrimary,TextSize=c.Gui.DefaultTextSize,TextXAlignment=Enum.TextXAlignment.
Left,TextYAlignment=e.TextYAlignment or Enum.TextYAlignment.Center,TextWrapped=e
.TextWrapped or false,AutomaticSize=e.AutomaticSize or Enum.AutomaticSize.None,
Selectable=false,Text=e.Text or'',Name=e.Name or'TextBox',LayoutOrder=e.
LayoutOrder or 0})end,function(e)e=e or{}local f,g=e.Color or c.Colors.
BackgroundMedium,e.Transparency or c.Gui.AutocompleteBackgroundTransparency
return b('Frame',{BackgroundColor3=f,BackgroundTransparency=g,BorderSizePixel=0,
LayoutOrder=e.LayoutOrder or 0,Name=e.Name or'',Size=e.Size or UDim2.new(1,0,0,
20)},e.Children)end return function()local l=d()c.GuiRoot=l local m=b(
'TextButton',{BackgroundColor3=c.Colors.BackgroundMedium,BackgroundTransparency=
c.Gui.AutocompleteBackgroundTransparency,BorderSizePixel=0,Font=Enum.Font.Code,
Size=UDim2.new(1,0,0,30),Text='',TextColor3=c.Colors.TextPrimary,TextSize=14,
TextXAlignment=Enum.TextXAlignment.Left},{h{Name='Typed',TextColor3=c.Colors.
AutocompleteItem,Size=UDim2.new(1,0,1,0)},h{Name='Suggest',Size=UDim2.new(1,0,1,
0)},f{left=10,top=0,bottom=0,right=0}})local n=b('ScreenGui',{Name='CoCo',
DisplayOrder=1000,ResetOnSpawn=false,AutoLocalize=false,Parent=l},{e{Name=
'Frame',Children={g(),i{Name='Line',Text='made with \u{2661}',AutomaticSize=Enum
.AutomaticSize.Y,TextWrapped=true,TextYAlignment=Enum.TextYAlignment.Top},f(),b(
'Frame',{BackgroundTransparency=1,LayoutOrder=c.Gui.EntryLayoutOrder,Name=
'Entry',Size=UDim2.new(1,0,0,20)},{g(Enum.FillDirection.Horizontal),i{
LayoutOrder=c.Gui.EntryLayoutOrder,PlaceholderText='enter a command here',
Position=UDim2.new(0,140,0,0)},h{Text='',TextColor3=c.Colors.TextAccent,
AutomaticSize=Enum.AutomaticSize.X,Size=UDim2.new(0,0,0,20)}})}},e{Name=
'Autocomplete',BackgroundColor3=c.Colors.BackgroundMedium,BackgroundTransparency
=c.Gui.AutocompleteBackgroundTransparency,Position=UDim2.new(0,167,0,75),Size=
UDim2.new(0,200,0,200),Children={g(),j{Color=c.Colors.BackgroundMedium,
Transparency=c.Gui.SectionBackgroundTransparency,LayoutOrder=-2,Name='Title',
Size=UDim2.new(1,0,0,40),Children={h{Name='Field',Text='from',Font=Enum.Font.
SourceSansBold,TextSize=20,Size=UDim2.new(0,37,1,0),Children={h{Name='Type',Font
=Enum.Font.SourceSans,TextSize=15,Size=UDim2.new(0,0,1,0),Position=UDim2.new(1,0
,0,0)}}},f{left=10,top=0,bottom=0,right=0}}},j{Color=c.Colors.BackgroundMedium,
Transparency=c.Gui.SectionBackgroundTransparency,LayoutOrder=-1,Name=
'Description',Size=UDim2.new(1,0,0,20),Children={h{Name='Label',Text=
[[The players to teleport. The players to teleport. The players to teleport. The players to teleport. ]]
,Font=Enum.Font.SourceSansLight,TextSize=16,TextWrapped=true,Size=UDim2.new(1,0,
1,0),TextYAlignment=Enum.TextYAlignment.Top},f{left=10,top=10,bottom=10,right=10
}}},m}}})return n end end function a.l()local c=a.cache.l if not c then c={c=b()
}a.cache.l=c end return c.c end end do local b=function()local b,c,d,e,f,g,h,i,j
=a.d(),{Validate=function(b)return b~=nil end,Parse=function(b)return tostring(b
)end},{Transform=function(b)return tonumber(b)end,Validate=function(b)return b~=
nil end,Parse=function(b)return b end},{Transform=function(b)return tonumber(b)
end,Validate=function(b)return b~=nil and b==math.floor(b),
'Only whole numbers are valid.'end,Parse=function(b)return b end},{Transform=
function(b)return tonumber(b)end,Validate=function(b)return b~=nil and b==math.
floor(b)and b>0,'Only positive whole numbers are valid.'end,Parse=function(b)
return b end},{Transform=function(b)return tonumber(b)end,Validate=function(b)
return b~=nil and b==math.floor(b)and b>=0,
'Only non-negative whole numbers are valid.'end,Parse=function(b)return b end},{
Transform=function(b)return tonumber(b)end,Validate=function(b)return b~=nil and
b==math.floor(b)and b>=0 and b<=255,'Only bytes are valid.'end,Parse=function(b)
return b end},{Transform=function(b)return tonumber(b)end,Validate=function(b)
return b~=nil and b==math.floor(b)and b>=0 and b<=9,'Only digits are valid.'end,
Parse=function(b)return b end}do local l,m=b.makeDictionary{'true','t','yes','y'
,'on','enable','enabled','1','+'},b.makeDictionary{'false','f','no','n','off',
'disable','disabled','0','-'}j={Transform=function(n)return n:lower()end,
Validate=function(n)return l[n]~=nil or m[n]~=nil,
'Please use true/yes/on or false/no/off.'end,Parse=function(n)if l[n]then return
true elseif m[n]then return false else return nil end end}end return function(l)
l:registerType('string',c)l:registerType('number',d)l:registerType('integer',e)l
:registerType('positiveInteger',f)l:registerType('nonNegativeInteger',g)l:
registerType('byte',h)l:registerType('digit',i)l:registerType('boolean',j)l:
registerType('strings',b.makeListableType(c))l:registerType('numbers',b.
makeListableType(d))l:registerType('integers',b.makeListableType(e))l:
registerType('positiveIntegers',b.makeListableType(f))l:registerType(
'nonNegativeIntegers',b.makeListableType(g))l:registerType('bytes',b.
makeListableType(h))l:registerType('digits',b.makeListableType(i))l:
registerType('booleans',b.makeListableType(j))end end function a.m()local c=a.
cache.m if not c then c={c=b()}a.cache.m=c end return c.c end end do local b=
function()local b,c,d=a.b(),{},function(b)local c={}for d=1,#b do c[d]=b[d].Name
end return c,b end function c.makeFuzzyFinder(e)local f,g={}if typeof(e)=='Enum'
then e=e:GetEnumItems()end if typeof(e)=='Instance'then g,f=d(e:GetChildren())
elseif typeof(e)=='table'then if typeof(e[1])=='Instance'or typeof(e[1])==
'EnumItem'or(typeof(e[1])=='table'and typeof(e[1].Name)=='string')then g,f=d(e)
elseif type(e[1])=='string'then g=e elseif e[1]~=nil then error
[[MakeFuzzyFinder only accepts tables of instances or strings.]]else g={}end
else error'MakeFuzzyFinder only accepts a table, Enum, or Instance.'end return
function(h,i)local j={}for l,m in pairs(g)do local n=f and f[l]or m if m:lower()
==h:lower()then if i then return n else table.insert(j,1,n)end elseif m:lower():
find(h:lower(),1,true)then j[#j+1]=n end end if i then return j[1]end return j
end end function c.getNames(e)return b.List.map(e,function(f)return f.Name or
tostring(f)end)end function c.makeEnumType(e,f)local g=c.makeFuzzyFinder(f)
return{Validate=function(h)return g(h,true)~=nil,('Value %q is not a valid %s.')
:format(h,e)end,Autocomplete=function(h)local i=g(h)return type(i[1])~='string'
and c.getNames(i)or i end,Parse=function(h)return g(h,true)end}end return c end
function a.n()local c=a.cache.n if not c then c={c=b()}a.cache.n=c end return c.
c end end do local b=function()local b=a.a()local c,d=b.Players,{}function d.
getCharacterPosition(e)if not e then return nil end local f=e:FindFirstChild
'HumanoidRootPart'or e:FindFirstChild'Torso'if f then return f.Position end
return nil end d.ArgumentOperatorAliases={me='.',all='*',others='**',random='?'}
d.Selectors={Keyword={allies=function(e)local f=e.Team if not f then return{}end
local g={}for h,i in ipairs(c:GetPlayers())do if i.Team==f then table.insert(g,i
.Name)end end return g end,team='allies',enemies=function(e)local f,g=e.Team,{}
for h,i in ipairs(c:GetPlayers())do if not f or i.Team~=f then table.insert(g,i.
Name)end end return g end,nonteam='enemies',friends=function(e)local f,g=pcall(
function()return c:GetFriendsAsync(e.UserId)end)if not f then return{}end local
h={}pcall(function()while true do local i=g:GetCurrentPage()for j,l in ipairs(i)
do h[l.Id]=true end if g:IsFinished()then break end g:AdvanceToNextPageAsync()
end end)local i={}for j,l in ipairs(c:GetPlayers())do if h[l.UserId]then table.
insert(i,l.Name)end end return i end,nonfriends=function(e)local f,g=pcall(
function()return c:GetFriendsAsync(e.UserId)end)if not f then local h={}for i,j
in ipairs(c:GetPlayers())do table.insert(h,j.Name)end return h end local h={}
pcall(function()while true do local i=g:GetCurrentPage()for j,l in ipairs(i)do h
[l.Id]=true end if g:IsFinished()then break end g:AdvanceToNextPageAsync()end
end)local i={}for j,l in ipairs(c:GetPlayers())do if not h[l.UserId]then table.
insert(i,l.Name)end end return i end,nearest=function(e)local f=d.
getCharacterPosition(e.Character)if not f then return{}end local g,h=(math.huge)
for i,j in ipairs(c:GetPlayers())do if j~=e then local l=d.getCharacterPosition(
j.Character)if l then local m=(l-f).Magnitude if m<g then g=m h=j.Name end end
end end if h then return{h}end return{}end,farthest=function(e)local f=d.
getCharacterPosition(e.Character)if not f then return{}end local g,h=(-1)for i,j
in ipairs(c:GetPlayers())do if j~=e then local l=d.getCharacterPosition(j.
Character)if l then local m=(l-f).Magnitude if m>g then g=m h=j.Name end end end
end if h then return{h}end return{}end,furthest='farthest',alive=function(e)
local f={}for g,h in ipairs(c:GetPlayers())do local i=h.Character and h.
Character:FindFirstChildWhichIsA'Humanoid'if i and i.Health>0 then table.insert(
f,h.Name)end end return f end,dead=function(e)local f={}for g,h in ipairs(c:
GetPlayers())do local i=h.Character and h.Character:FindFirstChildWhichIsA
'Humanoid'if not i or i.Health<=0 then table.insert(f,h.Name)end end return f
end,cursor=function(e)local f=b.Players.LocalPlayer local g=f and f:GetMouse()if
not g then return{}end local h,i,j=g.Hit.Position,(math.huge)for l,m in ipairs(c
:GetPlayers())do local n=d.getCharacterPosition(m.Character)if n then local o=(n
-h).Magnitude if o<i then i=o j=m.Name end end end if j then return{j}end return
{}end,npcs=function(e)local f={}for g,h in ipairs(b.Workspace:GetDescendants())
do if not h:IsA'Player'then local i=h:FindFirstChildWhichIsA'Humanoid'if i and h
.Parent then local j=i.Parent.Name if not c:FindFirstChild(j)then table.insert(f
,j)end end end end return f end},Pattern={{Pattern='^age(%d+)$',Resolve=function
(e,f)local g,h=tonumber(f[1]),{}for i,j in ipairs(c:GetPlayers())do if j.
AccountAge<=g then table.insert(h,j.Name)end end return h end,Invert=function(e,
f)local g,h=tonumber(f[1]),{}for i,j in ipairs(c:GetPlayers())do if j.AccountAge
>g then table.insert(h,j.Name)end end return h end},{Pattern='^rad(%d+)$',
Resolve=function(e,f)local g,h=tonumber(f[1]),d.getCharacterPosition(e.Character
)if not h then return{}end local i={}for j,l in ipairs(c:GetPlayers())do if l~=e
then local m=d.getCharacterPosition(l.Character)if m and(m-h).Magnitude<=g then
table.insert(i,l.Name)end end end return i end,Invert=function(e,f)local g,h=
tonumber(f[1]),d.getCharacterPosition(e.Character)if not h then return{}end
local i={}for j,l in ipairs(c:GetPlayers())do if l~=e then local m=d.
getCharacterPosition(l.Character)if not m or(m-h).Magnitude>g then table.insert(
i,l.Name)end end end return i end},{Pattern='^group(%d+)$',Resolve=function(e,f)
local g,h=tonumber(f[1]),{}for i,j in ipairs(c:GetPlayers())do if j:IsInGroup(g)
then table.insert(h,j.Name)end end return h end,Invert=function(e,f)local g,h=
tonumber(f[1]),{}for i,j in ipairs(c:GetPlayers())do if not j:IsInGroup(g)then
table.insert(h,j.Name)end end return h end},{Pattern='^#(%d+)$',Resolve=function
(e,f)local g,h=tonumber(f[1]),c:GetPlayers()if#h==0 then return{}end local i={}
for j=1,#h do i[j]=j end local j,l=math.min(g,#h),{}for m=1,j do local n=math.
random(1,#i)table.insert(l,h[table.remove(i,n)].Name)end return l end,Invert=
function(e,f)local g,h=tonumber(f[1]),c:GetPlayers()if#h==0 then return{}end
local i={}for j=1,#h do i[j]=j end local j,l=math.min(g,#h),{}for m=1,j do local
n=math.random(1,#i)l[h[table.remove(i,n)].Name]=true end local m={}for n,o in
ipairs(h)do if not l[o.Name]then table.insert(m,o.Name)end end return m end}}}
function d.buildAutocomplete(e,f)local g,h={},false if f then local i,j=(f.
TextSegmentInProgress or''):lower(),{}for l,m in ipairs(e)do j[m:lower()]=true
end if f.Type.ArgumentOperatorAliases then for l in pairs(f.Type.
ArgumentOperatorAliases)do if type(l)=='string'then local m,n=l:lower(),f.Type.
ArgumentOperatorAliases[l]if i~=''and(m:sub(1,#i)==i or(n and i:sub(1,#n)==n))
and not j[m]then if l=='me'or l=='random'or f.Type.Listable then table.insert(e,
l)j[m]=true h=true elseif l=='all'or l=='others'then local o,p=c:GetPlayers(),f.
Executor and f.Executor.Name for q,r in ipairs(o)do if l~='others'or not p or r.
Name~=p then local s=r.Name:lower()if not j[s]then table.insert(e,r.Name)j[s]=
true end end end h=true end end end end end if f.Type.Selectors then if f.Type.
Selectors.Keyword then for l in pairs(f.Type.Selectors.Keyword)do if type(l)==
'string'then local m=l:lower()if i~=''and m:sub(1,#i)==i and not j[m]then local
n=f:resolveKeywordResolver(l)if n then local o=n(f.Executor)if#o>0 then if not f
.Type.Listable then for p,q in ipairs(o)do local r=q:lower()if not j[r]then
table.insert(e,q)j[r]=true end end else table.insert(e,l)j[m]=true end h=true
end end end end end end if f.Type.Selectors.Pattern then for l,m in ipairs(f.
Type.Selectors.Pattern)do local n=m.Pattern:match'^%^([a-z]+)%('if n then if i~=
''and n:sub(1,#i)==i and not j[n]then table.insert(e,n..'#')j[n]=true h=true end
end end end end if h and#i>0 then g.IsPartial=true end end return e,g end return
d end function a.o()local c=a.cache.o if not c then c={c=b()}a.cache.o=c end
return c.c end end do local b=function()local b,c,d,e=a.n(),a.d(),a.o(),a.a()
local f=e.Players local g={Transform=function(g)local h=b.makeFuzzyFinder(f:
GetPlayers())return h(g)end,Validate=function(g)return#g>0,
'No player with that name could be found.'end,Autocomplete=function(g,h)return d
.buildAutocomplete(b.getNames(g),h)end,Parse=function(g)return g[1]end,Default=
function(g)return g.Name end,ArgumentOperatorAliases=d.ArgumentOperatorAliases,
Selectors=d.Selectors}return function(h)h:registerType('player',g)h:
registerType('players',c.makeListableType(g,{Prefixes='% teamPlayers'}))end end
function a.p()local c=a.cache.p if not c then c={c=b()}a.cache.p=c end return c.
c end end do local b=function()local b=a.a()local c,d,e=b.Teams,a.n(),a.d()local
f={Transform=function(f)local g=d.makeFuzzyFinder(c:GetTeams())return g(f)end,
Validate=function(f)return#f>0,'No team with that name could be found.'end,
Autocomplete=function(f)return d.getNames(f)end,Parse=function(f)return f[1]end}
local g,h={Listable=true,Transform=f.Transform,Validate=f.Validate,Autocomplete=
f.Autocomplete,Parse=function(g)return g[1]:GetPlayers()end},{Transform=f.
Transform,Validate=f.Validate,Autocomplete=f.Autocomplete,Parse=function(g)
return g[1].TeamColor end}return function(i)i:registerType('team',f)i:
registerType('teams',e.makeListableType(f))i:registerType('teamPlayers',g)i:
registerType('teamColor',h)i:registerType('teamColors',e.makeListableType(h))end
end function a.q()local c=a.cache.q if not c then c={c=b()}a.cache.q=c end
return c.c end end do local b=function()local b,c,d=a.n(),a.d(),{'White','Grey',
'Light yellow','Brick yellow','Light green (Mint)','Light reddish violet',
'Pastel Blue','Light orange brown','Nougat','Bright red','Med. reddish violet',
'Bright blue','Bright yellow','Earth orange','Black','Dark grey','Dark green',
'Medium green','Lig. Yellowich orange','Bright green','Dark orange',
'Light bluish violet','Transparent','Tr. Red','Tr. Lg blue','Tr. Blue',
'Tr. Yellow','Light blue','Tr. Flu. Reddish orange','Tr. Green','Tr. Flu. Green'
,'Phosph. White','Light red','Medium red','Medium blue','Light grey',
'Bright violet','Br. yellowish orange','Bright orange','Bright bluish green',
'Earth yellow','Bright bluish violet','Tr. Brown','Medium bluish violet',
'Tr. Medi. reddish violet','Med. yellowish green','Med. bluish green',
'Light bluish green','Br. yellowish green','Lig. yellowish green',
'Med. yellowish orange','Br. reddish orange','Bright reddish violet',
'Light orange','Tr. Bright bluish violet','Gold','Dark nougat','Silver',
'Neon orange','Neon green','Sand blue','Sand violet','Medium orange',
'Sand yellow','Earth blue','Earth green','Tr. Flu. Blue','Sand blue metallic',
'Sand violet metallic','Sand yellow metallic','Dark grey metallic',
'Black metallic','Light grey metallic','Sand green','Sand red','Dark red',
'Tr. Flu. Yellow','Tr. Flu. Red','Gun metallic','Red flip/flop',
'Yellow flip/flop','Silver flip/flop','Curry','Fire Yellow',
'Flame yellowish orange','Reddish brown','Flame reddish orange',
'Medium stone grey','Royal blue','Dark Royal blue','Bright reddish lilac',
'Dark stone grey','Lemon metalic','Light stone grey','Dark Curry','Faded green',
'Turquoise','Light Royal blue','Medium Royal blue','Rust','Brown',
'Reddish lilac','Lilac','Light lilac','Bright purple','Light purple',
'Light pink','Light brick yellow','Warm yellowish orange','Cool yellow',
'Dove blue','Medium lilac','Slime green','Smoky grey','Dark blue',
'Parsley green','Steel blue','Storm blue','Lapis','Dark indigo','Sea green',
'Shamrock','Fossil','Mulberry','Forest green','Cadet blue','Electric blue',
'Eggplant','Moss','Artichoke','Sage green','Ghost grey','Lilac','Plum','Olivine'
,'Laurel green','Quill grey','Crimson','Mint','Baby blue','Carnation pink',
'Persimmon','Maroon','Gold','Daisy orange','Pearl','Fog','Salmon','Terra Cotta',
'Cocoa','Wheat','Buttermilk','Mauve','Sunrise','Tawny','Rust','Cashmere','Khaki'
,'Lily white','Seashell','Burgundy','Cork','Burlap','Beige','Oyster','Pine Cone'
,'Fawn brown','Hurricane grey','Cloudy grey','Linen','Copper','Dirt brown',
'Bronze','Flint','Dark taupe','Burnt Sienna','Institutional white','Mid gray',
'Really black','Really red','Deep orange','Alder','Dusty Rose','Olive',
'New Yeller','Really blue','Navy blue','Deep blue','Cyan','CGA brown','Magenta',
'Pink','Deep orange','Teal','Toothpaste','Lime green','Camo','Grime','Lavender',
'Pastel light blue','Pastel orange','Pastel violet','Pastel blue-green',
'Pastel green','Pastel yellow','Pastel brown','Royal purple','Hot pink'}local e=
b.makeFuzzyFinder(d)local f={Prefixes='% teamColor',Transform=function(f)local g
={}for h,i in pairs(e(f))do g[h]=BrickColor.new(i)end return g end,Validate=
function(f)return#f>0,'No valid brick colors with that name could be found.'end,
Autocomplete=function(f)return b.getNames(f)end,Parse=function(f)return f[1]end}
local g={Transform=f.Transform,Validate=f.Validate,Autocomplete=f.Autocomplete,
Parse=function(g)return g[1].Color end}return function(h)h:registerType(
'brickColor',f)h:registerType('brickColors',c.makeListableType(f,{Prefixes=
'% teamColors'}))h:registerType('brickColor3',g)h:registerType('brickColor3s',c.
makeListableType(g))end end function a.r()local c=a.cache.r if not c then c={c=
b()}a.cache.r=c end return c.c end end do local b=function()local b,c=a.b(),a.d(
)local d,e=c.makeSequenceType{Prefixes='# hexColor3 ! brickColor3',ValidateEach=
function(d,e)if d==nil then return false,(
'Invalid or missing number at position %d in Color3 type.'):format(e)elseif d<0
or d>255 then return false,(
[[Number out of acceptable range 0-255 at position %d in Color3 type.]]):format(
e)elseif d%1~=0 then return false,(
'Number is not an integer at position %d in Color3 type.'):format(e)end return
true end,TransformEach=tonumber,Constructor=Color3.fromRGB,Length=3},function(d)
if#d==1 then d=d..d end return tonumber(d,16)end local f={Transform=function(f)
local g,h,i=f:match'^#?(%x%x?)(%x%x?)(%x%x?)$'return unpack(b.List.map({g,h,i},e
))end,Validate=function(f,g,h)return f~=nil and g~=nil and h~=nil,
'Invalid hex color'end,Parse=function(...)return Color3.fromRGB(...)end}return
function(g)g:registerType('color3',d)g:registerType('color3s',c.
makeListableType(d,{Prefixes='# hexColor3s ! brickColor3s'}))g:registerType(
'hexColor3',f)g:registerType('hexColor3s',c.makeListableType(f))end end function
a.s()local c=a.cache.s if not c then c={c=b()}a.cache.s=c end return c.c end end
do local b=function()local b,c=a.d(),function(b,c)if b==nil then return false,(
'Invalid or missing number at position %d in Vector type.'):format(c)end return
true end local d,e=b.makeSequenceType{ValidateEach=c,TransformEach=tonumber,
Constructor=Vector3.new,Length=3},b.makeSequenceType{ValidateEach=c,
TransformEach=tonumber,Constructor=Vector2.new,Length=2}return function(f)f:
registerType('vector3',d)f:registerType('vector3s',b.makeListableType(d))f:
registerType('vector2',e)f:registerType('vector2s',b.makeListableType(e))end end
function a.t()local c=a.cache.t if not c then c={c=b()}a.cache.t=c end return c.
c end end do local b=function()local b,c=a.n(),a.d()return function(d)local e={
Transform=function(e)local f=b.makeFuzzyFinder(d:getCommandNames())return f(e)
end,Validate=function(e)return#e>0,'No command with that name could be found.'
end,Autocomplete=function(e)return e end,Parse=function(e)return e[1]end}d:
registerType('command',e)d:registerType('commands',c.makeListableType(e))end end
function a.u()local c=a.cache.u if not c then c={c=b()}a.cache.u=c end return c.
c end end do local b=function()local b,c=a.n(),a.d()return function(d)local e={
Transform=function(e)local f=b.makeFuzzyFinder(d:getTypeNames())return f(e)end,
Validate=function(e)return#e>0,'No type with that name could be found.'end,
Autocomplete=function(e)return e end,Parse=function(e)return e[1]end}d:
registerType('type',e)d:registerType('types',c.makeListableType(e))end end
function a.v()local c=a.cache.v if not c then c={c=b()}a.cache.v=c end return c.
c end end do local b=function()local b=a.n()return function(c)c:registerType(
'bindableResource',b.makeEnumType('BindableResource',{'Chat'}))end end function
a.w()local c=a.cache.w if not c then c={c=b()}a.cache.w=c end return c.c end end
do local b=function()local b=a.n()return function(c)c:registerType(
'conditionFunction',b.makeEnumType('ConditionFunction',{'startsWith'}))end end
function a.x()local c=a.cache.x if not c then c={c=b()}a.cache.x=c end return c.
c end end do local b=function()local b,c,d,e=a.n(),a.d(),{Years=31556926,Months=
2629744,Weeks=604800,Days=86400,Hours=3600,Minutes=60,Seconds=1},{}for f,g in
pairs(d)do table.insert(e,f)end local f=b.makeFuzzyFinder(e)local g,h=function(g
)if g==nil or g==''then return nil end local h=tonumber(g)if h and h==0 then
return 0,0,true end local i=g:gsub('-?%d+%a+','')local j=i:match'-?%d+'if j then
return nil,tonumber(j),true end local l,m,n for o in g:gmatch'-?%d+%a+'do m,n=o:
match'(-?%d+)(%a+)'local p=f(n)if#p==0 then return nil,tonumber(m)end if l==nil
then l=0 end l=l+(n:lower()=='m'and 60 or d[p[1] ])*tonumber(m)end if l==nil
then return nil else return l,tonumber(m)end end,function(g,h,i,j)j=j or 1 local
l={}for m,n in ipairs(g)do if i==1 then l[m]=h..n:sub(j,#n-1)else l[m]=h..n:sub(
j)end end return l end local i={Transform=function(i)return i,g(i)end,Validate=
function(i,j)return j~=nil end,Autocomplete=function(i,j,l,m,n)local o={}if m or
n then local p=m==true and f''or n if m==true then o=h(p,i,l)else local q=i:
match'^.*(%a+)$':len()o=h(p,i,q+1)end elseif j~=nil then local p=i:match
'^.*-?%d+(%a+)%s?$'local q=f(p)o=h(q,i,l,#p+1)table.sort(o)end return o end,
Parse=function(i,j)return j end}return function(j)j:registerType('duration',i)j:
registerType('durations',c.makeListableType(i))end end function a.y()local c=a.
cache.y if not c then c={c=b()}a.cache.y=c end return c.c end end do local b=
function()local b=a.a()local c=b.HttpService return function(d)d:registerType(
'json',{Validate=function(e)local f=pcall(c.JSONDecode,c,e)if not f then return
false,'Invalid JSON'end return true end,Parse=function(e)return c:JSONDecode(e)
end})end end function a.z()local c=a.cache.z if not c then c={c=b()}a.cache.z=c
end return c.c end end do local b=function()local b=a.n()return function(c)c:
registerType('mathOperator',b.makeEnumType('Math Operator',{{Name='+',Perform=
function(d,e)return d+e end},{Name='-',Perform=function(d,e)return d-e end},{
Name='*',Perform=function(d,e)return d*e end},{Name='/',Perform=function(d,e)
return d/e end},{Name='**',Perform=function(d,e)return d^e end},{Name='%',
Perform=function(d,e)return d%e end}}))end end function a.A()local c=a.cache.A
if not c then c={c=b()}a.cache.A=c end return c.c end end do local b=function()
local b,c,d,e=a.n(),a.d(),a.o(),a.a()local f,g=e.Players,{}local h=function(h)if
g[h]then return g[h]elseif f:FindFirstChild(h)then g[h]=f[h].UserId return f[h].
UserId else local i,j=pcall(f.GetUserIdFromNameAsync,f,h)if not i then return
nil,'Failed to get user ID for '..h end g[h]=j return j end end local i={
DisplayName='Full Player Name',Prefixes='# integer',Transform=function(i)local j
=b.makeFuzzyFinder(f:GetPlayers())return i,j(i)end,ValidateOnce=function(i)
return h(i)~=nil,'No player with that name could be found.'end,Autocomplete=
function(i,j,l)return d.buildAutocomplete(b.getNames(j),l)end,Parse=function(i)
return h(i)end,Default=function(i)return i.Name end,ArgumentOperatorAliases=d.
ArgumentOperatorAliases,Selectors=d.Selectors}return function(j)j:registerType(
'playerId',i)j:registerType('playerIds',c.makeListableType(i,{Prefixes=
'# integers'}))end end function a.B()local c=a.cache.B if not c then c={c=b()}a.
cache.B=c end return c.c end end do local b=function()local b,c,d,e=a.n(),a.d(),
a.b(),{'^%a[%w_]*$','^%$%a[%w_]*$','^%.%a[%w_]*$','^%$%.%a[%w_]*$'}return
function(f)local g={Autocomplete=function(g)local h=b.makeFuzzyFinder(d.
Dictionary.keys(f:getStore'vars_used'or{}))return h(g)end,Validate=function(g)
for h,i in ipairs(e)do if g:match(i)then return true end end return false,
[[Key names must start with an optional modifier: . $ or $. and must begin with a letter.]]
end,Parse=function(g)return g end}f:registerType('storedKey',g)f:registerType(
'storedKeys',c.makeListableType(g))end end function a.C()local c=a.cache.C if
not c then c={c=b()}a.cache.C=c end return c.c end end do local b=function()
local b,c=a.d(),{Validate=function(b)if b:match'^https?://.+$'then return true
end return false,'URLs must begin with http:// or https://'end,Parse=function(b)
return b end}return function(d)d:registerType('url',c)d:registerType('urls',b.
makeListableType(c))end end function a.D()local c=a.cache.D if not c then c={c=
b()}a.cache.D=c end return c.c end end do local b=function()local b,c,d=a.n(),a.
d(),Enum.UserInputType:GetEnumItems()for e,f in ipairs(Enum.KeyCode:
GetEnumItems())do d[#d+1]=f end local e={Transform=function(e)local f=b.
makeFuzzyFinder(d)return f(e)end,Validate=function(e)return#e>0 end,Autocomplete
=function(e)return b.getNames(e)end,Parse=function(e)return e[1]end}return
function(f)f:registerType('userInput',e)f:registerType('userInputs',c.
makeListableType(e))end end function a.E()local c=a.cache.E if not c then c={c=
b()}a.cache.E=c end return c.c end end do local b=function()local b,c,d,e,f=a.c(
),a.n(),Enum.KeyCode:GetEnumItems(),{LeftControl='Ctrl',RightControl='Ctrl',
LeftShift='Shift',RightShift='Shift',LeftAlt='Alt',RightAlt='Alt'},{}for g in
pairs(e)do for h,i in ipairs(d)do if i.Name==g then f[i]=true end end end local
g,h={},{}for i,j in ipairs(d)do local l=e[j.Name]if l then if not g[l]then g[l]=
{}end table.insert(g[l],j)h[#h+1]=j end end local i={}for j,l in ipairs(d)do if
not f[l]then table.insert(i,l)end end local j={Transform=function(j)if not j or#
j==0 then return{}end if j:lower()=='list'then return{mode='list'}end local l,m=
b.splitStringSimple(j,'+'),''for n=1,#l-1 do m=m..l[n]..'+'end local n,o=l[#l]or
'',c.makeFuzzyFinder(i)local p=o(n)return{prefix=m,parts=l,matches=p,lastPart=n}
end,Validate=function(j)if not j then return false,'No value provided.'end if j.
mode=='list'then return true end if not j.matches or#j.matches==0 then return
false,'Could not find a matching key.'end return true end,Autocomplete=function(
j,l)local m=l and l.Command and l.Command.Name:lower()=='unbind'if not j or not
j.matches then if m then local n,o=l.Command.CoCo.Registry:getStore'COCO_Binds',
{}for p,q in pairs(n)do if type(q)=='table'and q.mode then o[#o+1]=p end end
return o end return{'list'}end if j.mode=='list'then return{'list'}end local n,o
=c.getNames(j.matches),{}if m then local p=l.Command.CoCo.Registry:getStore
'COCO_Binds'for q,r in ipairs(n)do local s=j.prefix..r if p[s]then o[#o+1]=s end
end return o end for p,q in ipairs(n)do o[#o+1]=j.prefix..q end if#j.parts==1
and(#j.lastPart==0 or string.lower(string.sub('list',1,#j.lastPart))==string.
lower(j.lastPart))then table.insert(o,1,'list')end return o end,Parse=function(j
)if not j then return nil end if j.mode=='list'then return nil end if not j.
matches or#j.matches==0 then return nil end local l,m,n=j.matches[1],{},j.parts
for o=1,#n-1 do local p=n[o]local q=g[p]if q then for r,s in ipairs(q)do m[s]=
true end end end return{key=l,modifiers=m,text=j.prefix..l.Name}end}return
function(l)l:registerType('keycombo',j)end end function a.F()local c=a.cache.F
if not c then c={c=b()}a.cache.F=c end return c.c end end do local b=function()
return function(b)b.Registry:registerType('flymethod',{Transform=function(c)
return c end,Validate=function(c)return c~=nil end,Parse=function(c)return c end
,Autocomplete=function(c)local d={'velocity','speed','vehicle','cframe'}if not c
or#c==0 then return d end local e,f=c:lower(),{}for g,h in ipairs(d)do if h:sub(
1,#e)==e then table.insert(f,h)end end return f end})b.Registry:registerType(
'flykeybinds',{Transform=function(c)return c end,Validate=function(c)return c~=
nil end,Parse=function(c)return c end,Autocomplete=function(c)local d={'default'
,'qe'}if not c or#c==0 then return d end local e,f=c:lower(),{}for g,h in
ipairs(d)do if h:sub(1,#e)==e then table.insert(f,h)end end return f end})end
end function a.G()local c=a.cache.G if not c then c={c=b()}a.cache.G=c end
return c.c end end do local b=function()local b=a.a()local c,d,e,f,g,h,i,j,l=b.
HttpService,a.g(),request or http_request or syn and syn.request,function(c)
return c:gsub('([^%w%.%-%~])',function(d)return string.format('%%%02X',string.
byte(d))end)end,100,{},{},{},function(c)if c>=1000000 then return string.format(
'%.1fM',c/1000000)elseif c>=1000 then return string.format('%.1fK',c/1000)end
return tostring(c)end j.formatNumber=l function j.buildBadgeStr(m)local n={}if m
.verified then table.insert(n,'Verified')end if m.isPatched then table.insert(n,
'Patched')end if m.key then table.insert(n,'Key')end if m.isUniversal then table
.insert(n,'Universal')end if#n>0 then return' ['..table.concat(n,'] [')..']'end
return''end function j.searchScripts(m)local n=
'https://scriptblox.com/api/script/search?q='..f(m)if not e then return nil end
local o,p=pcall(e,{Url=n,Method='GET'})if not o then return nil,'request_failed'
end if not p or p.StatusCode~=200 or not p.Body then return nil,'bad_response'
end local q,r=pcall(c.JSONDecode,c,p.Body)if q and r and r.result then return r.
result end return nil,'parse_failed'end function j.formatResult(m)local n={}for
o,p in ipairs(m)do local q,r,s,t,u=p.title or'Untitled',p.game and p.game.name
or'Unknown',j.buildBadgeStr(p),l(p.views or 0),l(p.likes or 0)table.insert(n,
string.format(' %d. %s',o,q))table.insert(n,string.format(
'    Game: %s  |  Views: %s  |  Likes: %s%s',r,t,u,s))end return table.concat(n,
'\n')end function j.runScript(m,n)local o,p,q,r,s,t=n.title or'Untitled',n.game
and n.game.name or'Unknown',j.buildBadgeStr(n),l(n.views or 0),l(n.likes or 0),n
.description and n.description:sub(1,200)or'No description'local u=string.
format([[=== %s ===
Game: %s
Views: %s  |  Likes: %s%s
Description: %s]],o,p,r,s
,q,t)m:reply(u,d.Colors.TextAccent)local v=n.script if not v or v==''then return
"Script '"..o.."' has no code."end local w,x=pcall(function()loadstring(v)()end)
if not w then return'Failed to execute script: '..tostring(x)end return
'Running: '..o end function j.cacheScript(m,n)if h[m]then h[m]=n return end h[m]
=n table.insert(i,m)if#i>g then local o=table.remove(i,1)h[o]=nil end end
function j.getCachedScript(m)return h[m]end function j.findScriptByPartialId(m)
for n,o in pairs(h)do if n:sub(1,#m):lower()==m:lower()then return o end end
return nil end return j end function a.H()local c=a.cache.H if not c then c={c=
b()}a.cache.H=c end return c.c end end do local b=function()local b=a.H()return
function(c)c:registerType('scriptblox',{Debounce=true,Transform=function(d)
return d end,Validate=function(d)return d~=nil end,Parse=function(d)return
tostring(d)end,Autocomplete=function(d,e)if type(d)~='string'or#d<2 then return{
},{IsPartial=true}end local f,g=pcall(b.searchScripts,d)if not f or not g or not
g.scripts then return{},{IsPartial=false}end local h,i=d:lower(),{}for j,l in
ipairs(g.scripts)do local m=l._id or l.id if l.title and m then b.cacheScript(m,
l)local n,o=l.title:lower(),0 if n==h then o=5 elseif n:find('^'..h:gsub(
'([%^%$%(%)%%%.%[%]%*%+%-%?])','%%%1'))then o=4 elseif n:find('[^%w]'..h:gsub(
'([%^%$%(%)%%%.%[%]%*%+%-%?])','%%%1'))or n:find('^'..h:gsub(
'([%^%$%(%)%%%.%[%]%*%+%-%?])','%%%1'))then o=3 elseif n:find(h:gsub(
'([%^%$%(%)%%%.%[%]%*%+%-%?])','%%%1'),1,true)then o=2 end table.insert(i,{
script=l,id=m,score=o})end end table.sort(i,function(j,l)if j.score~=l.score
then return j.score>l.score end return(j.script.views or 0)>(l.script.views or 0
)end)local j={}for l,m in ipairs(i)do local n=m.script local o,p,q,r=b.
formatNumber(n.views or 0),n.key and'Yes'or'No',(n.scriptType=='paid')and'No'or
'Yes',n.isPatched and'Yes'or'No'table.insert(j,{title=m.id,name=n.title,metaDesc
=string.format('Views: %s  |  Key: %s  |  Free: %s  |  Patched: %s',o,p,q,r)})
end return j,{IsPartial=true}end})end end function a.I()local c=a.cache.I if not
c then c={c=b()}a.cache.I=c end return c.c end end do local b=function()return{
Name='age',Aliases={},Description=
'Show the account age of a player. Usage: age <player>',Group='DefaultDebug',
Args={{Type='player',Name='target',Description='The player to check'}},ClientRun
=function(b,c)b:reply(("%s's account age: %d days"):format(c.Name,c.AccountAge))
return("Checked %s's age."):format(c.Name)end}end function a.J()local c=a.cache.
J if not c then c={c=b()}a.cache.J=c end return c.c end end do local b=function(
)local b=a.a()local c=b.Lighting return{Name='ambient',Aliases={},Description=
'Set ambient lighting color (R G B).',Group='DefaultDebug',Args={{Type='color3',
Name='color',Description='RGB color values (0-255)'}},ClientRun=function(d,e)if
not e then return'Usage: ambient <R> <G> <B>'end c.OutdoorAmbient=e return(
'Ambient set to RGB(%d, %d, %d).'):format(e.R*255,e.G*255,e.B*255)end}end
function a.K()local c=a.cache.K if not c then c={c=b()}a.cache.K=c end return c.
c end end do local b=function()return{Name='anchor',Aliases={'anc'},
InverseAliases={'unanchor'},Description='Toggle anchor on your root part.',Group
='DefaultDebug',Args={},ClientRun=function(b)local c=b.Executor.Character if not
c then return'No character.'end local d=c:FindFirstChild'HumanoidRootPart'or c:
FindFirstChild'Torso'if not d then return'No root part found.'end if b:
isInvertedCall()then if not d.Anchored then return'Already unanchored.'end d.
Anchored=false return'Unanchored.'end d.Anchored=not d.Anchored return d.
Anchored and'Anchored.'or'Unanchored.'end}end function a.L()local c=a.cache.L if
not c then c={c=b()}a.cache.L=c end return c.c end end do local b=function()
return{Name='animation',Aliases={'anim'},Description='Play an animation by ID.',
Group='DefaultDebug',Args={{Type='string',Name='id',Description=
'Animation ID (number)'},{Type='number',Name='speed',Description=
'Playback speed (optional)',Optional=true}},ClientRun=function(b,c,d)local e=b.
Executor.Character if not e then return"You don't have a character."end local f=
e:FindFirstChildWhichIsA'Humanoid'if not f then return'No humanoid found.'end
local g=c:match'(%d+)'if not g then return'Invalid animation ID.'end local h=
Instance.new'Animation'h.AnimationId='rbxassetid://'..g local i=f:LoadAnimation(
h)i.Priority=Enum.AnimationPriority.Movement i:Play()if d then i:AdjustSpeed(
math.clamp(d,0.1,10))end return('Playing animation %s.'):format(g)end}end
function a.M()local c=a.cache.M if not c then c={c=b()}a.cache.M=c end return c.
c end end do local b=function()return{Name='animspeed',Aliases={},Description=
'Adjust playback speed of all playing animations.',Group='DefaultDebug',Args={{
Type='number',Name='speed',Description='Speed multiplier (0.1-10)',Default=1}},
ClientRun=function(b,c)local d=b.Executor.Character if not d then return
"You don't have a character."end local e=d:FindFirstChildWhichIsA'Humanoid'if
not e then return'No humanoid found.'end c=math.clamp(c,0.1,10)local f=0 for g,h
in ipairs(e:GetPlayingAnimationTracks())do h:AdjustSpeed(c)f=f+1 end return(
'Adjusted speed of %d animation(s) to %g.'):format(f,c)end}end function a.N()
local c=a.cache.N if not c then c={c=b()}a.cache.N=c end return c.c end end do
local b=function()local b,c,d=game:GetService'VirtualUser',false return{Name=
'antiafk',Aliases={'antiidle'},Description=
'Toggle anti-AFK (prevents being kicked for idling).',Group='DefaultDebug',Args=
{},ClientRun=function(e)if c then if d then d:Disconnect()d=nil end c=false
return'Anti-AFK disabled.'end if getconnections then for f,g in ipairs(
getconnections(e.Executor.Idled))do if g.Disable then g:Disable()elseif g.
Disconnect then g:Disconnect()end end else d=e.Executor.Idled:Connect(function()
b:CaptureController()b:ClickButton2(Vector2.new())end)end c=true return
'Anti-AFK enabled.'end}end function a.O()local c=a.cache.O if not c then c={c=b(
)}a.cache.O=c end return c.c end end do local b=function()local b=a.a()local c,d
,e=b.Lighting,false local f=function()d=false if e then e:Disconnect()e=nil end
c.GlobalShadows=true c.FogEnd=100000 c.FogStart=0 settings().Rendering.
QualityLevel=21 end return{Name='antilag',Aliases={'boostfps','lowgraphics'},
InverseAliases={'unantilag'},Description=
'Toggle anti-lag (lower graphics, disable shadows, etc.).',Group='DefaultDebug',
Args={},ClientRun=function(g)if g:isInvertedCall()then if not d then return
'Anti-lag already disabled.'end f()return'Anti-lag disabled.'end if d then f()
return'Anti-lag disabled.'end d=true local h=workspace:FindFirstChildWhichIsA
'Terrain'if h then h.WaterWaveSize=0 h.WaterWaveSpeed=0 h.WaterReflectance=0 h.
WaterTransparency=1 end c.GlobalShadows=false c.FogEnd=9e9 c.FogStart=9e9
settings().Rendering.QualityLevel=1 local i=function()for i,j in ipairs(game:
GetDescendants())do if j:IsA'BasePart'then j.CastShadow=false j.Material=Enum.
Material.Plastic j.Reflectance=0 elseif j:IsA'Decal'then j.Transparency=1 j.
Texture=''elseif j:IsA'ParticleEmitter'or j:IsA'Trail'then j.Lifetime=
NumberRange.new(0)end end for i,j in ipairs(c:GetDescendants())do if j:IsA
'PostEffect'then j.Enabled=false end end end i()e=workspace.DescendantAdded:
Connect(function(j)task.spawn(function()task.wait()if not d then return end if j
:IsA'BasePart'then j.CastShadow=false j.Material=Enum.Material.Plastic j.
Reflectance=0 elseif j:IsA'Decal'then j.Transparency=1 j.Texture=''elseif j:IsA
'ParticleEmitter'or j:IsA'Trail'then j.Lifetime=NumberRange.new(0)end end)end)
return'Anti-lag enabled.'end}end function a.P()local c=a.cache.P if not c then c
={c=b()}a.cache.P=c end return c.c end end do local b=function()local b=a.a()
local c,d,e,f=b.RunService,false local g=function()if e then e:Disconnect()e=nil
end if f then f:Disconnect()f=nil end d=false end return{Name='autojump',Aliases
={'ajump'},InverseAliases={'unautojump','noautojump'},Description=
'Toggle auto jump (jump when hitting an obstacle).',Group='DefaultDebug',Args={}
,ClientRun=function(h)if h:isInvertedCall()then if not d then return
'Auto jump already disabled.'end g()return'Auto jump disabled.'end if d then g()
return'Auto jump disabled.'end d=true local i=function(i)if e then e:Disconnect(
)end local j=i and i:FindFirstChildWhichIsA'Humanoid'local l=j and j.RootPart if
not l or not j then return end e=c.RenderStepped:Connect(function()if not d then
return end local m=h.Executor.Character local n=m and m:FindFirstChildWhichIsA
'Humanoid'local o=n and n.RootPart if not o or not n then return end local p,q=o
.Position-Vector3.new(0,1.5,0),o.CFrame.LookVector*3 local r=workspace:Raycast(p
,q)if r then n.Jump=true end end)end i(h.Executor.Character)f=h.Executor.
CharacterAdded:Connect(function(j)j:WaitForChild'Humanoid'i(j)end)return
'Auto jump enabled.'end}end function a.Q()local c=a.cache.Q if not c then c={c=
b()}a.cache.Q=c end return c.c end end do local b=function()return{Name='blink',
Aliases={'b','mouseteleport','mousetp'},Description=
'Teleports you to where your mouse is hovering.',Group='DefaultDebug',Args={},
ClientRun=function(b)local c,d=b.Executor:GetMouse(),b.Executor.Character if not
d then return"You don't have a character."end d:MoveTo(c.Hit.p)return'Blinked!'
end}end function a.R()local c=a.cache.R if not c then c={c=b()}a.cache.R=c end
return c.c end end do local b=function()return{Name='breakvelocity',Aliases={},
Description='Stop all momentum on your character.',Group='DefaultDebug',Args={},
ClientRun=function(b)local c=b.Executor.Character local d=c and c:
FindFirstChildWhichIsA'Humanoid'local e=d and d.RootPart if not e then return
'No root part found.'end e.Velocity=Vector3.zero e.RotVelocity=Vector3.zero
return'Velocity broken.'end}end function a.S()local c=a.cache.S if not c then c=
{c=b()}a.cache.S=c end return c.c end end do local b=function()return{Name=
'bringpart',Aliases={},Description='Bring a part to your position by name.',
Group='DefaultDebug',Args={{Type='string',Name='partName',Description=
'Name of the part to bring'}},ClientRun=function(b,c)local d=b.Executor.
Character if not d then return"You don't have a character."end local e=d:
FindFirstChildWhichIsA'Humanoid'if not e then return'No humanoid found.'end
local f=e.RootPart if not f then return'No root part.'end local g=0 for h,i in
ipairs(workspace:GetDescendants())do if i:IsA'BasePart'and i.Name:lower()==c:
lower()then i.CFrame=f.CFrame*CFrame.new(0,5,-5)g=g+1 end end return(
'Brought %d part(s) named %q.'):format(g,c)end}end function a.T()local c=a.cache
.T if not c then c={c=b()}a.cache.T=c end return c.c end end do local b=function
()return{Name='btools',Aliases={},Description=
'Give HopperBin building tools (move, resize, copy, color).',Group=
'DefaultDebug',Args={},ClientRun=function(b)local c=b.Executor:
FindFirstChildWhichIsA'Backpack'if not c then return'No backpack found.'end for
d=1,4 do local e=Instance.new'HopperBin'e.BinType=d e.Parent=c end return
'Building tools added to backpack.'end}end function a.U()local c=a.cache.U if
not c then c={c=b()}a.cache.U=c end return c.c end end do local b=function()
local b,c,d,e,f,g,h,i,j,l,m,n=a.a(),{F=0,B=0,L=0,R=0,Q=0,E=0},{F=0,B=0,L=0,R=0,Q
=0,E=0},0,{[Enum.KeyCode.W]='F',[Enum.KeyCode.S]='B',[Enum.KeyCode.A]='L',[Enum.
KeyCode.D]='R',[Enum.KeyCode.Q]='E',[Enum.KeyCode.E]='Q'},function(b)return b:
FindFirstChild'HumanoidRootPart'or b:FindFirstChild'Torso'end,{flying=false,
method='velocity',keyBinds='default',flySpeed=50,vehicleFlySpeed=1,cFlySpeed=50,
character=nil}local o=function()if l then l:Disconnect()l=nil end if m then m:
Disconnect()m=nil end end local p=function()o()l=b.UserInputService.InputBegan:
Connect(function(p,q)if q then return end if p.UserInputType~=Enum.UserInputType
.Keyboard then return end local r=f[p.KeyCode]if not r then return end if not h.
flying then return end local s=h.method=='vehicle'and h.vehicleFlySpeed or h.
flySpeed if r=='F'then c.F=s elseif r=='B'then c.B=-s elseif r=='L'then c.L=-s
elseif r=='R'then c.R=s elseif h.keyBinds=='qe'then if r=='Q'then c.E=-s*2
elseif r=='E'then c.Q=s*2 end end local t=workspace.CurrentCamera if t then t.
CameraType=Enum.CameraType.Track end end)m=b.UserInputService.InputEnded:
Connect(function(p,q)if q then return end if p.UserInputType~=Enum.UserInputType
.Keyboard then return end local r=f[p.KeyCode]if r then if r=='F'then c.F=0
elseif r=='B'then c.B=0 elseif r=='L'then c.L=0 elseif r=='R'then c.R=0 elseif r
=='E'then c.Q=0 elseif r=='Q'then c.E=0 end end end)end local q,r,s=function()
local q=h.character if not q then return end local r=g(q)if not r then return
end h.flying=true local s=Instance.new'BodyGyro's.P=9e4 s.MaxTorque=Vector3.new(
9e9,9e9,9e9)s.CFrame=r.CFrame s.Parent=r i=s local t=Instance.new'BodyVelocity't
.Velocity=Vector3.new(0,0,0)t.MaxForce=Vector3.new(9e9,9e9,9e9)t.Parent=r j=t
local u=q:FindFirstChildOfClass'Humanoid'if u and h.method~='vehicle'then u.
PlatformStand=true end p()task.spawn(function()while h.flying and i and i.Parent
do task.wait()local v=q:FindFirstChildOfClass'Humanoid'if v and h.method~=
'vehicle'then v.PlatformStand=true end if c.L+c.R~=0 or c.F+c.B~=0 or c.Q+c.E~=0
then e=50 d.F=c.F d.B=c.B d.L=c.L d.R=c.R d.Q=c.Q d.E=c.E elseif e~=0 then e=0
end local w=workspace.CurrentCamera if w and j then if(c.L+c.R)~=0 or(c.F+c.B)~=
0 or(c.Q+c.E)~=0 then j.Velocity=((w.CFrame.LookVector*(c.F+c.B))+((w.CFrame*
CFrame.new(c.L+c.R,(c.F+c.B+c.Q+c.E)*0.2,0).p)-w.CFrame.p))*e elseif e~=0 then j
.Velocity=((w.CFrame.LookVector*(d.F+d.B))+((w.CFrame*CFrame.new(d.L+d.R,(d.F+d.
B+c.Q+c.E)*0.2,0).p)-w.CFrame.p))*e else j.Velocity=Vector3.new(0,0,0)end if i
then i.CFrame=w.CFrame end end end c={F=0,B=0,L=0,R=0,Q=0,E=0}d={F=0,B=0,L=0,R=0
,Q=0,E=0}e=0 if i then i:Destroy()i=nil end if j then j:Destroy()j=nil end local
v=q:FindFirstChildOfClass'Humanoid'if v then v.PlatformStand=false end o()end)
end,function()local q=h.character if not q then return end local r=q:
FindFirstChildOfClass'Humanoid'if not r then return end local s=q:FindFirstChild
'Head'if not s then return end h.flying=true r.PlatformStand=true s.Anchored=
true if n then n:Disconnect()end n=b.RunService.Heartbeat:Connect(function(t)if
not h.flying then return end local u,v,w=r.MoveDirection*(h.cFlySpeed*t),s.
CFrame,workspace.CurrentCamera if not w then return end local x=w.CFrame local y
=v:ToObjectSpace(x).Position x=x*CFrame.new(-y.X,-y.Y,-y.Z+1)local z,A=x.
Position,v.Position local B=CFrame.new(z,Vector3.new(A.X,z.Y,A.Z)):
VectorToObjectSpace(u)s.CFrame=CFrame.new(A)*(x-z)*CFrame.new(B)end)end,function
()if n then n:Disconnect()n=nil end local q=h.character if q then local r=q:
FindFirstChildOfClass'Humanoid'if r then r.PlatformStand=false end local s=q:
FindFirstChild'Head'if s then s.Anchored=false end end end local t,u=function()
if h.method=='cframe'then r()else q()end end,function()h.flying=false o()if n
then s()end local t=workspace.CurrentCamera if t then t.CameraType=Enum.
CameraType.Custom end end function h:fly()if not self.character then return end
if self.flying then self:flyMethod(self.method)else t()end end function h:
flyMethod(v)self.method=v u()task.wait()t()end function h:flyStop()u()end
function h:flyToggle()if self.flying then u()else t()end end function h:setSpeed
(v)if self.method=='cframe'then self.cFlySpeed=v elseif self.method=='vehicle'
then self.vehicleFlySpeed=v else self.flySpeed=v end end return h end function a
.V()local c=a.cache.V if not c then c={c=b()}a.cache.V=c end return c.c end end
do local b=function()local b=a.V()return{Name='cframefly',Aliases={'cfly'},
InverseAliases={'uncframefly','nocframefly'},Description=
'Toggle CFrame-based fly (no physics).',Group='DefaultDebug',Args={},ClientRun=
function(c)if c:isInvertedCall()then if not b.flying or b.method~='cframe'then
return'CFrame fly already disabled.'end b:flyStop()b.method='velocity'return
'CFrame fly disabled.'end local d=c.Executor.Character if not d then return
"You don't have a character."end b.character=d if b.flying and b.method==
'cframe'then b:flyStop()b.method='velocity'return'CFrame fly disabled.'end b:
flyMethod'cframe'return'CFrame fly enabled.'end}end function a.W()local c=a.
cache.W if not c then c={c=b()}a.cache.W=c end return c.c end end do local b=
function()return{Name='chardelete',Aliases={'cd'},Description=
"Delete a player's character.",Group='DefaultDebug',Args={{Type='player',Name=
'target',Description='The player whose character to delete'}},ClientRun=function
(b,c)local d=c.Character if not d then return'Target has no character.'end local
e=d:FindFirstChildWhichIsA'Humanoid'if e then e:Destroy()end d:Destroy()return(
"Deleted %s's character."):format(c.Name)end}end function a.X()local c=a.cache.X
if not c then c={c=b()}a.cache.X=c end return c.c end end do local b=function()
return{Name='charscale',Aliases={'scale'},Description=
'Scale your character size (0.1-10).',Group='DefaultDebug',Args={{Type='number',
Name='scale',Description='Scale factor (default: 1)',Default=1}},ClientRun=
function(b,c)local d=b.Executor.Character if not d then return
"You don't have a character."end local e=d:FindFirstChildWhichIsA'Humanoid'if
not e then return'No humanoid found.'end local f=e.RootPart if not f then return
'No root part found.'end c=math.clamp(c,0.1,10)local g=f.CFrame f.Size=f.Size*c
for h,i in ipairs(d:GetDescendants())do if i:IsA'BasePart'and i~=f then local j=
g:ToObjectSpace(i.CFrame)i.Size=i.Size*c i.CFrame=g*CFrame.new(j.Position*c)*j.
Rotation end end return('Character scaled to %g.'):format(c)end}end function a.Y
()local c=a.cache.Y if not c then c={c=b()}a.cache.Y=c end return c.c end end do
local b=function()local b,c=a.a(),game:GetService'ReplicatedStorage'return{Name=
'chat',Aliases={'say'},Description='Send a chat message.',Group='DefaultDebug',
Args={{Type='string',Name='message',Description='The message to send'}},
ClientRun=function(d,e)if b.TextChatService.ChatVersion==Enum.ChatVersion.
TextChatService then local f=b.TextChatService:FindFirstChild'RBXGeneral'if f
then f:SendAsync(e)end else local f=c:FindFirstChild
'DefaultChatSystemChatEvents'if f then local g=f:FindFirstChild
'SayMessageRequest'if g then g:FireServer(e,'All')end end end return(
'Message sent: %s'):format(e)end}end function a.Z()local c=a.cache.Z if not c
then c={c=b()}a.cache.Z=c end return c.c end end do local b=function()return{
Name='clearchar',Aliases={'clearcharappearance'},Description=
'Clear all character accessories and clothing.',Group='DefaultDebug',Args={},
ClientRun=function(b)local c=b.Executor.Character if not c then return
"You don't have a character."end local d=0 for e,f in ipairs(c:GetChildren())do
if f:IsA'Accessory'or f:IsA'Hat'or f:IsA'Shirt'or f:IsA'Pants'or f:IsA
'ShirtGraphic'then f:Destroy()d=d+1 end end local e=c:FindFirstChild'Head'if e
then for f,g in ipairs(e:GetChildren())do if g:IsA'SpecialMesh'or g:IsA'Decal'
then if g.Name~='face'then g:Destroy()d=d+1 end end end end return(
'Cleared %d item(s).'):format(d)end}end function a._()local c=a.cache._ if not c
then c={c=b()}a.cache._=c end return c.c end end do local b=function()return{
Name='clearwaypoints',Aliases={'cwp','clearpositions','clearpos'},Description=
'Delete all saved waypoints.',Group='DefaultDebug',Args={},ClientRun=function(b)
local c,d=b:getStore'Waypoints',0 for e,f in c do c[e]=nil d=d+1 end return(
'Cleared %d waypoint(s).'):format(d)end}end function a.aa()local c=a.cache.aa if
not c then c={c=b()}a.cache.aa=c end return c.c end end do local b=function()
local b=a.a()local c,d,e=b.UserInputService,false return{Name='clickdelete',
Aliases={},Description=
[[Toggle click-delete mode. Hold LeftAlt and click to delete parts.]],Group=
'DefaultDebug',Args={},ClientRun=function()if d then if e then e:Disconnect()e=
nil end d=false return'Click-delete disabled.'end d=true e=c.InputBegan:Connect(
function(f,g)if g then return end if f.UserInputType~=Enum.UserInputType.
MouseButton1 then return end if not c:IsKeyDown(Enum.KeyCode.LeftAlt)then return
end local h=game:GetService'Players'.LocalPlayer:GetMouse()local i=h.Target if i
then local j=i:IsA'BasePart'and i or i.Parent if j then j:Destroy()end end end)
return'Click-delete enabled (hold LeftAlt + click).'end}end function a.ab()local
c=a.cache.ab if not c then c={c=b()}a.cache.ab=c end return c.c end end do local
b=function()local b,c,d=game:GetService'UserInputService',false return{Name=
'clickteleport',Aliases={'ctp'},InverseAliases={'unclickteleport','noctp'},
Description='Toggle click-teleport (click anywhere to teleport there).',Group=
'DefaultDebug',Args={},ClientRun=function(e)if e:isInvertedCall()then if not c
then return'Click-TP already disabled.'end c=false if d then d:Disconnect()d=nil
end return'Click-TP disabled.'end if c then c=false if d then d:Disconnect()d=
nil end return'Click-TP disabled.'end local f=e.Executor:GetMouse()d=b.
InputBegan:Connect(function(g,h)if h then return end if g.UserInputType~=Enum.
UserInputType.MouseButton1 then return end local i=e.Executor.Character if not i
then return end local j=i:FindFirstChildWhichIsA'Humanoid'local l=j and j.
RootPart if l then l.CFrame=CFrame.new(f.Hit.p)end end)c=true return
'Click-TP enabled.'end}end function a.ac()local c=a.cache.ac if not c then c={c=
b()}a.cache.ac=c end return c.c end end do local b=function()local b=a.a()local
c=b.StarterGui return{Name='console',Aliases={},Description=
'Toggle the Roblox developer console (F9).',Group='DefaultDebug',Args={},
ClientRun=function()local d=c:GetCore'DevConsoleVisible'c:SetCore(
'DevConsoleVisible',not d)return d and'Console closed.'or'Console opened.'end}
end function a.ad()local c=a.cache.ad if not c then c={c=b()}a.cache.ad=c end
return c.c end end do local b=function()return{Name='copyname',Aliases={
'copyuser'},Description="Copy a player's name. Usage: copyname <player>",Group=
'DefaultDebug',Args={{Type='player',Name='target',Description=
'The player to copy the name of'}},ClientRun=function(b,c)pcall(setclipboard,c.
Name)return("Copied %s's name."):format(c.Name)end}end function a.ae()local c=a.
cache.ae if not c then c={c=b()}a.cache.ae=c end return c.c end end do local b=
function()return{Name='copytools',Aliases={},Description=
'Copy all tools from a player.',Group='DefaultDebug',Args={{Type='player',Name=
'target',Description='The player to copy tools from'}},ClientRun=function(b,c)
local d=b.Executor.Character if not d then return"You don't have a character."
end local e=c.Character if not e then return'Target has no character.'end local
f=d:FindFirstChildWhichIsA'Humanoid'if not f then return'No humanoid found.'end
local g=0 for h,i in ipairs(e:GetChildren())do if i:IsA'Tool'then i.Archivable=
true local j=i:Clone()j.Parent=d g=g+1 end end local h=c:FindFirstChild
'Backpack'if h then for i,j in ipairs(h:GetChildren())do if j:IsA'Tool'then j.
Archivable=true local l=j:Clone()l.Parent=d g=g+1 end end end return(
'Copied %d tool(s) from %s.'):format(g,c.Name)end}end function a.af()local c=a.
cache.af if not c then c={c=b()}a.cache.af=c end return c.c end end do local b=
function()local b,c,d={'27789359','30196114','248263260','45834924','33796059',
'28488254','52155728'},{'3333432454','4555808220','4049037604','4555782893',
'10214311282','10714010337','10713981723','10714372526','10714076981',
'10714392151','11444443576'}return{Name='dance',Aliases={},InverseAliases={
'undance','nodance'},Description='Toggle a random dance animation.',Group=
'DefaultDebug',Args={},ClientRun=function(e)if e:isInvertedCall()then if not d
then return'Not dancing.'end d:Stop()d:Destroy()d=nil return'Dance stopped.'end
if d then d:Stop()d:Destroy()d=nil return'Dance stopped.'end local f=e.Executor.
Character if not f then return"You don't have a character."end local g=f:
FindFirstChildWhichIsA'Humanoid'if not g then return'No humanoid found.'end
local h=g.RigType==Enum.HumanoidRigType.R15 and c or b local i,j=h[math.random(#
h)],Instance.new'Animation'j.AnimationId='rbxassetid://'..i d=g:LoadAnimation(j)
d.Looped=true d:Play()return'Dancing!'end}end function a.ag()local c=a.cache.ag
if not c then c={c=b()}a.cache.ag=c end return c.c end end do local b=function()
return{Name='datalimit',Aliases={},Description=
[[Set outgoing KBPS data limit. Usage: datalimit <kbps> | datalimit (disables)]]
,Group='DefaultDebug',Args={{Type='number',Name='kbps',Description=
'Outgoing data limit in KB/s',Optional=true}},ClientRun=function(b,c)local d,e=
game:GetService'NetworkClient',c or 0 d:SetOutgoingKBPSLimit(e)if e>0 then
return('Data limit set to %d KB/s.'):format(e)end return'Data limit disabled.'
end}end function a.ah()local c=a.cache.ah if not c then c={c=b()}a.cache.ah=c
end return c.c end end do local b=function()local b=a.a()local c=b.Lighting
return{Name='day',Aliases={},Description='Set lighting to daytime.',Group=
'DefaultDebug',Args={},ClientRun=function()c.ClockTime=12 return
'Time set to day (12:00).'end}end function a.ai()local c=a.cache.ai if not c
then c={c=b()}a.cache.ai=c end return c.c end end do local b=function()local b=a
.a()local c=b.Players return{Name='delete',Aliases={'del','remove'},Description=
"Delete the object you're looking at.",Group='DefaultDebug',Args={},ClientRun=
function()local d=c.LocalPlayer:GetMouse()local e=d.Target if not e then return
'No object targeted.'end local f=e.Name e:Destroy()return('Deleted %s.'):format(
f)end}end function a.aj()local c=a.cache.aj if not c then c={c=b()}a.cache.aj=c
end return c.c end end do local b=function()return{Name='deletewaypoint',Aliases
={'dwp','deleteposition','deletepos'},Description='Delete a saved waypoint.',
Group='DefaultDebug',Args={{Type={Transform=function(b)return b end,Validate=
function(b)return b~=nil end,Parse=function(b)return tostring(b)end,Autocomplete
=function(b,c)local d,e=c.Registry:getStore'Waypoints',{}for f,g in pairs(d)do
table.insert(e,g.name)end return e end},Name='name',Description=
'Name of the waypoint to delete'}},ClientRun=function(b,c)local d,e=b:getStore
'Waypoints',c:lower()local f=d[e]if not f then return('Waypoint "%s" not found.'
):format(c)end d[e]=nil return('Deleted waypoint "%s".'):format(f.name)end}end
function a.ak()local c=a.cache.ak if not c then c={c=b()}a.cache.ak=c end return
c.c end end do local b=function()return{Name='drophats',Aliases={'drophat'},
Description='Drop all worn hats/accessories.',Group='DefaultDebug',Args={},
ClientRun=function(b)local c=b.Executor.Character if not c then return
"You don't have a character."end local d=0 for e,f in ipairs(c:GetChildren())do
if f:IsA'Accessory'or f:IsA'Hat'then f.Parent=workspace d=d+1 end end return(
'Dropped %d hat(s).'):format(d)end}end function a.al()local c=a.cache.al if not
c then c={c=b()}a.cache.al=c end return c.c end end do local b=function()return{
Name='droptools',Aliases={},Description='Drop all held tools.',Group=
'DefaultDebug',Args={},ClientRun=function(b)local c=b.Executor.Character if not
c then return"You don't have a character."end local d=c:FindFirstChildWhichIsA
'Humanoid'if not d then return'No humanoid found.'end local e=0 for f,g in
ipairs(c:GetChildren())do if g:IsA'Tool'then d:UnequipTools()g.Parent=workspace
e=e+1 end end return('Dropped %d tool(s).'):format(e)end}end function a.am()
local c=a.cache.am if not c then c={c=b()}a.cache.am=c end return c.c end end do
local b=function()local b=a.a()local c,d,e=b.RunService,(b.Workspace)return{Name
='edgejump',Aliases={'ejump'},InverseAliases={'unedgejump','noejump'},
Description='Toggle auto-jump at edges (jumps when about to walk off).',Group=
'DefaultDebug',Args={},ClientRun=function(f)if f:isInvertedCall()then if not e
then return'Edge jump already disabled.'end e:Disconnect()e=nil return
'Edge jump disabled.'end if e then e:Disconnect()e=nil return
'Edge jump disabled.'end e=c.RenderStepped:Connect(function()local g=f.Executor.
Character if not g then return end local h=g:FindFirstChildWhichIsA'Humanoid'if
not h then return end local i=h.RootPart if not i then return end if h.
MoveDirection.Magnitude==0 then return end local j,l=i.Position-Vector3.new(0,2,
0),i.CFrame.LookVector*4 local m=d:Raycast(j,l)if not m then h.Jump=true end end
)return'Edge jump enabled.'end}end function a.an()local c=a.cache.an if not c
then c={c=b()}a.cache.an=c end return c.c end end do local b=function()local b
local c=function(c,...)local d=b b=nil c(...)b=d end local d,e=function()while
true do c(coroutine.yield())end end,{}e.__index=e function e.new(f,g)return
setmetatable({_connected=true,_signal=f,_fn=g,_next=false},e)end function e:
Disconnect()self._connected=false if self._signal._handlerListHead==self then
self._signal._handlerListHead=self._next else local f=self._signal.
_handlerListHead while f and f._next~=self do f=f._next end if f then f._next=
self._next end end end setmetatable(e,{__index=function(f,g)error((
'Attempt to get Connection::%s (not a valid member)'):format(tostring(g)),2)end,
__newindex=function(f,g)error((
'Attempt to set Connection::%s (not a valid member)'):format(tostring(g)),2)end}
)local f={}f.__index=f function f.new()return(setmetatable({_handlerListHead=
false},f))end function f:Connect(g)local h=e.new(self,g)if self._handlerListHead
then h._next=self._handlerListHead self._handlerListHead=h else self.
_handlerListHead=h end return h end function f:DisconnectAll()self.
_handlerListHead=false end function f:Fire(...)local g=self._handlerListHead
while g do if g._connected then if not b then b=coroutine.create(d)coroutine.
resume(b)end coroutine.resume(b,g._fn,...)end g=g._next end end function f:Wait(
)local g,h=(coroutine.running())h=self:Connect(function(...)h:Disconnect()
coroutine.resume(g,...)end)return coroutine.yield()end function f:Once(g)local h
h=self:Connect(function(...)if h._connected then h:Disconnect()end g(...)end)
return h end setmetatable(f,{__index=function(g,h)error((
'Attempt to get Signal::%s (not a valid member)'):format(tostring(h)),2)end,
__newindex=function(g,h)error(('Attempt to set Signal::%s (not a valid member)')
:format(tostring(h)),2)end})return f end function a.ao()local c=a.cache.ao if
not c then c={c=b()}a.cache.ao=c end return c.c end end do local b=function()
local b,c=a.ao(),{'neutral','friendly','enemy','local','target'}local d=function
()return{Enabled=false,ShowEnemies=true,ShowFriendlies=true,ShowNeutral=true,
ShowLocal=false,ShowTarget=true,TeamCheck=false,UseTeamColors=false,MaxDistance=
2500,UseDisplayName=false,LimitFPS=0,Features={box=true,['box fill']=false,name=
true,['health bar']=true,['health text']=true,distance=true,['tool text']=false,
highlight=false},ShowOn={box=c,['box fill']=c,name=c,['health bar']=c,[
'health text']=c,distance=c,['tool text']=c,highlight=c},TeamColors={neutral={
box=Color3.fromRGB(255,255,255),['box fill']=Color3.fromRGB(255,255,255),name=
Color3.fromRGB(255,255,255),['health bar']=Color3.fromRGB(0,255,0),[
'health text']=Color3.fromRGB(255,255,255),distance=Color3.fromRGB(255,255,255),
['tool text']=Color3.fromRGB(255,255,255),highlight=Color3.fromRGB(0,0,0)},
friendly={box=Color3.fromRGB(120,200,255),['box fill']=Color3.fromRGB(120,200,
255),name=Color3.fromRGB(120,200,255),['health bar']=Color3.fromRGB(120,200,255)
,['health text']=Color3.fromRGB(120,200,255),distance=Color3.fromRGB(120,200,255
),['tool text']=Color3.fromRGB(120,200,255),highlight=Color3.fromRGB(120,200,255
)},enemy={box=Color3.fromRGB(255,120,120),['box fill']=Color3.fromRGB(255,120,
120),name=Color3.fromRGB(255,120,120),['health bar']=Color3.fromRGB(255,120,120)
,['health text']=Color3.fromRGB(255,120,120),distance=Color3.fromRGB(255,120,120
),['tool text']=Color3.fromRGB(255,120,120),highlight=Color3.fromRGB(255,120,120
)},['local']={box=Color3.fromRGB(255,255,120),['box fill']=Color3.fromRGB(255,
255,120),name=Color3.fromRGB(255,255,120),['health bar']=Color3.fromRGB(255,255,
120),['health text']=Color3.fromRGB(255,255,120),distance=Color3.fromRGB(255,255
,120),['tool text']=Color3.fromRGB(255,255,120),highlight=Color3.fromRGB(255,255
,120)},target={box=Color3.fromRGB(193,91,91),['box fill']=Color3.fromRGB(193,91,
91),name=Color3.fromRGB(193,91,91),['health bar']=Color3.fromRGB(193,91,91),[
'health text']=Color3.fromRGB(193,91,91),distance=Color3.fromRGB(193,91,91),[
'tool text']=Color3.fromRGB(193,91,91),highlight=Color3.fromRGB(193,91,91)}},
TeamTransparencies={neutral={box=0,['box fill']=0.85,name=0,['health bar']=0,[
'health text']=0,distance=0,['tool text']=0,highlight=0.9},friendly={box=0,[
'box fill']=0.85,name=0,['health bar']=0,['health text']=0,distance=0,[
'tool text']=0,highlight=0.9},enemy={box=0,['box fill']=0.85,name=0,[
'health bar']=0,['health text']=0,distance=0,['tool text']=0,highlight=0.9},[
'local']={box=0,['box fill']=0.85,name=0,['health bar']=0,['health text']=0,
distance=0,['tool text']=0,highlight=0.9},target={box=0,['box fill']=0.85,name=0
,['health bar']=0,['health text']=0,distance=0,['tool text']=0,highlight=0.9}},
UniversalColors={neutral=Color3.fromRGB(255,255,255),friendly=Color3.fromRGB(120
,200,255),enemy=Color3.fromRGB(255,120,120),['local']=Color3.fromRGB(255,255,120
),target=Color3.fromRGB(193,91,91)},TextCasing='normal',ToolTextCasing=
'lowercase',HealthBarGap=3,HealthBarWidth=2,HealthBarOutline=1,HealthBarYOffset=
-2,HideFullHealthText=false,HealthBarGradientDirection='darker',
HighlightBehindWalls=true,HighlightTransparency=0.9,HighlightOutlineColor=Color3
.fromRGB(255,255,255),HighlightOutlineTransparency=0.2,DynamicBoxes=true,
DynamicBoxesCheap=true,DynamicBoxesIncludeAll=false,Changed=b.new()}end return{
create=d}end function a.ap()local c=a.cache.ap if not c then c={c=b()}a.cache.ap
=c end return c.c end end do local b=function()local b,c,d,e={'box fill',
'health bar','health text','tool text','box','name','distance','highlight'},{
'on','off','feature','useteamcolors','maxdistance','teamcheck','showenemies',
'showfriendlies','showneutral','showlocal','list','status','reset'},{
'useteamcolors','teamcheck','showenemies','showfriendlies','showneutral',
'showlocal'},function(b,c)local d,e={},b:lower()for f,g in c do if g:lower():
find(e,1,true)then d[#d+1]=g end end return d end local f,g,h=function(f,g)for h
,i in b do local j={}for l in i:gmatch'%S+'do j[#j+1]=l:lower()end if g+#j-1<=#f
then local l=true for m=1,#j do if f[g+m-1]:lower()~=j[m]then l=false break end
end if l then return i,g+#j end end end return nil,g end,function(f)local g={}
for h in f:gmatch'%S+'do g[#g+1]=h end return g end,{on=true,off=false,['true']=
true,['false']=false,yes=true,no=false,enable=true,enabled=true,disable=false,
disabled=false,['1']=true,['0']=false}local i,j=function(i)return h[i:lower()]
end,function(i)local j={}table.insert(j,string.format('Enabled: %s',i.Enabled
and'Yes'or'No'))table.insert(j,string.format('Use Team Colors: %s',i.
UseTeamColors and'Yes'or'No'))table.insert(j,string.format('Team Check: %s',i.
TeamCheck and'Yes'or'No'))table.insert(j,string.format('Max Distance: %d',i.
MaxDistance))table.insert(j,string.format('Show Enemies: %s',i.ShowEnemies and
'Yes'or'No'))table.insert(j,string.format('Show Friendlies: %s',i.ShowFriendlies
and'Yes'or'No'))table.insert(j,string.format('Show Neutral: %s',i.ShowNeutral
and'Yes'or'No'))table.insert(j,string.format('Show Local: %s',i.ShowLocal and
'Yes'or'No'))table.insert(j,'')table.insert(j,'Features:')for l,m in b do local
n=i.Features[m]or false table.insert(j,string.format('  %s: %s',m,n and'Yes'or
'No'))end table.insert(j,'')table.insert(j,'Usage: esp <subcommand> [args]')
table.insert(j,
[[Subcommands: on, off, toggle, feature, useteamcolors, maxdistance,]])table.
insert(j,
[[  teamcheck, showenemies, showfriendlies, showneutral, showlocal, list, status, reset]]
)return table.concat(j,'\n')end return{Name='esp',Aliases={'visuals'},
Description="Configure ESP overlay. Use 'esp list' for details.",Group=
'DefaultDebug',Args={{Type={DisplayName='subcommand',Transform=function(l)return
l:lower()end,Validate=function(l)return true end,Autocomplete=function(l)return
e(l,c)end,Parse=function(l)return l end},Name='action',Description=
'Subcommand: on, off, feature, useteamcolors, etc.',Optional=true},{Type={
DisplayName='value',Transform=function(l)return l end,Validate=function(l)return
true end,Autocomplete=function(l,m)if not m or not m.Command then return{}end
local n=m.Command.RawArguments local o,p,q=n and n[1]and n[1]:lower()or'',{},
false for r,s in d do if o==s then p={'on','off'}q=true break end end if q then
return e(l,p)end if o=='feature'then for r,s in b do p[#p+1]=s end p[#p+1]='on'p
[#p+1]='off'return e(l,p)end return{}end,Parse=function(l)return l end},Name=
'value',Description='Additional arguments for the subcommand',Optional=true,
Default=''}},ClientRun=function(l,m,n)local o=l.CoCo.ESP if not o then return
'ESP not loaded.'end if not m then o.Enabled=not o.Enabled o.Changed:Fire()
return'ESP '..(o.Enabled and'enabled'or'disabled')..'.'end local p,q=m:lower(),
g(n or'')if p=='on'then o.Enabled=true o.Changed:Fire()return'ESP enabled.'
elseif p=='off'then o.Enabled=false o.Changed:Fire()return'ESP disabled.'elseif
p=='feature'then if#q==0 then local r,s={},{}for t,u in b do if o.Features[u]
then r[#r+1]=u else s[#s+1]=u end end table.sort(r)table.sort(s)return string.
format('Enabled: %s\nDisabled: %s',#r>0 and table.concat(r,', ')or'none',#s>0
and table.concat(s,', ')or'none')end local r,s=f(q,1)if not r then return string
.format('Unknown feature. Valid: %s',table.concat(b,', '))end if s<=#q then
local t=i(q[s])if t~=nil then o.Features[r]=t else return string.format(
'Invalid state %q. Use on or off.',q[s])end else o.Features[r]=not o.Features[r]
end o.Changed:Fire()return string.format('ESP %s: %s',r,o.Features[r]and
'enabled'or'disabled')elseif p=='useteamcolors'then if#q>0 then local r=i(q[1])
if r~=nil then o.UseTeamColors=r else return'Usage: esp useteamcolors [on|off]'
end else o.UseTeamColors=not o.UseTeamColors end o.Changed:Fire()return string.
format('ESP team colors: %s',o.UseTeamColors and'enabled'or'disabled')elseif p==
'maxdistance'then if#q==0 then return string.format('Max distance: %d',o.
MaxDistance)end local r=tonumber(q[1])if not r or r<0 then return
'Usage: esp maxdistance <number>'end o.MaxDistance=r o.Changed:Fire()return
string.format('ESP max distance set to %d',r)elseif p=='teamcheck'then if#q>0
then local r=i(q[1])if r~=nil then o.TeamCheck=r else return
'Usage: esp teamcheck [on|off]'end else o.TeamCheck=not o.TeamCheck end o.
Changed:Fire()return string.format('ESP team check: %s',o.TeamCheck and'on'or
'off')elseif p=='showenemies'then if#q>0 then local r=i(q[1])if r~=nil then o.
ShowEnemies=r else return'Usage: esp showenemies [on|off]'end else o.ShowEnemies
=not o.ShowEnemies end o.Changed:Fire()return string.format(
'ESP show enemies: %s',o.ShowEnemies and'on'or'off')elseif p=='showfriendlies'
then if#q>0 then local r=i(q[1])if r~=nil then o.ShowFriendlies=r else return
'Usage: esp showfriendlies [on|off]'end else o.ShowFriendlies=not o.
ShowFriendlies end o.Changed:Fire()return string.format(
'ESP show friendlies: %s',o.ShowFriendlies and'on'or'off')elseif p==
'showneutral'then if#q>0 then local r=i(q[1])if r~=nil then o.ShowNeutral=r else
return'Usage: esp showneutral [on|off]'end else o.ShowNeutral=not o.ShowNeutral
end o.Changed:Fire()return string.format('ESP show neutral: %s',o.ShowNeutral
and'on'or'off')elseif p=='showlocal'then if#q>0 then local r=i(q[1])if r~=nil
then o.ShowLocal=r else return'Usage: esp showlocal [on|off]'end else o.
ShowLocal=not o.ShowLocal end o.Changed:Fire()return string.format(
'ESP show local: %s',o.ShowLocal and'on'or'off')elseif p=='list'or p=='status'
then return j(o)elseif p=='reset'then local r=a.ap()local s=r.create()for t,u in
pairs(s)do if t~='Changed'then o[t]=u end end o.Changed:Fire()return
'ESP settings reset to defaults.'else return string.format(
"Unknown subcommand %q. Type 'esp list' for help.",p)end end}end function a.aq()
local c=a.cache.aq if not c then c={c=b()}a.cache.aq=c end return c.c end end do
local b=function()return{Name='fakeout',Aliases={},Description=
[[Teleport to the void and back (detaches players sitting on you).]],Group=
'DefaultDebug',Args={},ClientRun=function(b)local c=b.Executor.Character if not
c then return"You don't have a character."end local d=c:FindFirstChildWhichIsA
'Humanoid'if not d then return'No humanoid.'end local e=d.RootPart if not e then
return'No root part.'end local f,g=e.CFrame,workspace.FallenPartsDestroyHeight
if g==-math.huge then g=-500 end e.CFrame=CFrame.new(0,g-25,0)task.wait(1)e.
CFrame=f return'Fakeout complete.'end}end function a.ar()local c=a.cache.ar if
not c then c={c=b()}a.cache.ar=c end return c.c end end do local b=function()
return{Name='fireclickdetectors',Aliases={'firecd'},Description=
'Fire all ClickDetectors within 50 studs.',Group='DefaultDebug',Args={},
ClientRun=function()local b=game:GetService'Players'.LocalPlayer local c=b.
Character if not c then return'No character.'end local d=c:
FindFirstChildWhichIsA'Humanoid'd=d and d.RootPart if not d then return
'No root part.'end local e,f=d.Position,0 for g,h in ipairs(workspace:
GetDescendants())do if h:IsA'ClickDetector'then local i=h.Parent if i and i:IsA
'BasePart'then local j=(i.Position-e).Magnitude if j<=50 then h:Click(b:
GetMouse().Hit.Position,b)f=f+1 end end end end return(
'Fired %d click detector(s).'):format(f)end}end function a.as()local c=a.cache.
as if not c then c={c=b()}a.cache.as=c end return c.c end end do local b=
function()return{Name='fireproximityprompts',Aliases={'firepp'},Description=
'Fire all ProximityPrompts within range.',Group='DefaultDebug',Args={},ClientRun
=function()local b=game:GetService'Players'.LocalPlayer local c=b.Character if
not c then return'No character.'end local d=c:FindFirstChildWhichIsA'Humanoid'd=
d and d.RootPart if not d then return'No root part.'end local e,f=d.Position,0
for g,h in ipairs(workspace:GetDescendants())do if h:IsA'ProximityPrompt'then
local i=h.Parent if i and i:IsA'BasePart'then local j=(i.Position-e).Magnitude
if j<=h.MaxActivationDistance then h:InputHoldBegin()task.wait()h:InputHoldEnd()
f=f+1 end end end end return('Fired %d proximity prompt(s).'):format(f)end}end
function a.at()local c=a.cache.at if not c then c={c=b()}a.cache.at=c end return
c.c end end do local b=function()return{Name='firstp',Aliases={},Description=
'Force first-person camera.',Group='DefaultDebug',Args={},ClientRun=function(b)
local c,d=workspace.CurrentCamera,b.Executor.Character c.CameraType=Enum.
CameraType.Fixed if d then local e=d:FindFirstChild'Head'if e then c.CFrame=
CFrame.new(e.Position)end end b.Executor.CameraMode=Enum.CameraMode.
LockFirstPerson return'First-person enabled.'end}end function a.au()local c=a.
cache.au if not c then c={c=b()}a.cache.au=c end return c.c end end do local b=
function()return{Name='fixcam',Aliases={'restorecam'},Description=
'Reset the camera to default state.',Group='DefaultDebug',Args={},ClientRun=
function(b)local c,d=workspace.CurrentCamera,b.Executor.Character if d then
local e=d:FindFirstChildWhichIsA'Humanoid'if e then c.CameraSubject=e end end c.
CameraType=Enum.CameraType.Custom b.Executor.CameraMinZoomDistance=0.5 b.
Executor.CameraMaxZoomDistance=400 return'Camera reset.'end}end function a.av()
local c=a.cache.av if not c then c={c=b()}a.cache.av=c end return c.c end end do
local b=function()local b return{Name='flashback',Aliases={'diedtp'},Description
='Save position on death, run again to teleport back.',Group='DefaultDebug',Args
={},ClientRun=function(c)local d=c.Executor.Character if not d then return
"You don't have a character."end local e=d:FindFirstChildWhichIsA'Humanoid'if
not e then return'No humanoid found.'end local f=e.RootPart if not f then return
'No root part.'end if b then f.CFrame=b local g=b b=nil return(
'Teleported to (%.0f, %.0f, %.0f).'):format(g.X,g.Y,g.Z)end b=f.CFrame e.Died:
Connect(function()b=nil end)return
'Position saved. Run flashback again to return.'end}end function a.aw()local c=a
.cache.aw if not c then c={c=b()}a.cache.aw=c end return c.c end end do local b=
function()local b=a.a()local c,d,e,f,g=b.RunService,false local h=function(h)d=
false if g then g:Disconnect()g=nil end if e then e:Disconnect()e=nil end if f
then f:Destroy()f=nil end local i=h.Executor.Character if i then for j,l in
ipairs(i:GetDescendants())do if l:IsA'BasePart'then l.CanCollide=true l.Massless
=false l.CustomPhysicalProperties=PhysicalProperties.new(0.7,0.3,0.5)end end
local j=i:FindFirstChildWhichIsA'Humanoid'if j then local l=j.RootPart if l then
for m,n in ipairs(l:GetChildren())do if n.ClassName=='BodyAngularVelocity'then n
:Destroy()end end end end end end return{Name='fling',Aliases={},InverseAliases=
{'unfling','nofling'},Description=
'Toggle fling (spins you into others at high speed).',Group='DefaultDebug',Args=
{},ClientRun=function(i)if i:isInvertedCall()then if not d then return
'Fling already disabled.'end h(i)return'Fling disabled.'end if d then h(i)return
'Fling disabled.'end local j=i.Executor.Character if not j then return
"You don't have a character."end local l=j:FindFirstChildWhichIsA'Humanoid'if
not l then return'No humanoid found.'end local m=l.RootPart if not m then return
'No root part found.'end for n,o in ipairs(j:GetDescendants())do if o:IsA
'BasePart'then o.CustomPhysicalProperties=PhysicalProperties.new(100,0.3,0.5)end
end e=c.Stepped:Connect(function()local n=i.Executor.Character if not n then
return end for o,p in ipairs(n:GetDescendants())do if p:IsA'BasePart'then p.
CanCollide=false end end end)task.wait(0.1)f=Instance.new'BodyAngularVelocity'f.
Name='FlingVelocity'f.Parent=m f.AngularVelocity=Vector3.new(0,99999,0)f.
MaxTorque=Vector3.new(0,math.huge,0)f.P=math.huge for n,o in ipairs(j:
GetChildren())do if o:IsA'BasePart'then o.CanCollide=false o.Massless=true o.
Velocity=Vector3.new(0,0,0)end end d=true g=l.Died:Connect(function()d=false if
f then f:Destroy()f=nil end if e then e:Disconnect()e=nil end if g then g:
Disconnect()g=nil end end)task.spawn(function()while d do if f then f.
AngularVelocity=Vector3.new(0,99999,0)end task.wait(0.2)if f then f.
AngularVelocity=Vector3.new(0,0,0)end task.wait(0.1)end end)return
'Fling enabled.'end}end function a.ax()local c=a.cache.ax if not c then c={c=b()
}a.cache.ax=c end return c.c end end do local b=function()local b=a.a()local c,d
,e,f,g=b.RunService,b.Workspace,false local h=function()e=false if g then g:
Disconnect()g=nil end if f then f:Destroy()f=nil end end return{Name='float',
Aliases={'platform'},InverseAliases={'unfloat','nofloat'},Description=
'Toggle floating on a platform beneath you.',Group='DefaultDebug',Args={},
ClientRun=function(i)if i:isInvertedCall()then if not e then return
'Float already disabled.'end h()return'Float disabled.'end if e then h()return
'Float disabled.'end local j=i.Executor.Character if not j then return
"You don't have a character."end f=Instance.new'Part'f.Name='FloatPlatform'f.
Size=Vector3.new(4,0.5,4)f.Transparency=0.5 f.CanCollide=true f.Material=Enum.
Material.Neon f.Color=Color3.fromRGB(100,200,255)f.Anchored=true f.Parent=d e=
true g=c.RenderStepped:Connect(function()if not e then return end local l=i.
Executor.Character if not l then return end local m=l:FindFirstChildWhichIsA
'Humanoid'if not m then return end local n=m.RootPart if not n then return end
local o=n.Position f.CFrame=CFrame.new(o.X,o.Y-3,o.Z)end)return'Float enabled.'
end}end function a.ay()local c=a.cache.ay if not c then c={c=b()}a.cache.ay=c
end return c.c end end do local b=function()local b=a.V()return{Name='fly',
Aliases={'f'},InverseAliases={'unfly','nofly'},Description=
'Toggle fly with WASD (and QE).',Group='DefaultDebug',Args={},ClientRun=function
(c)if c:isInvertedCall()then if not b.flying or b.method~='velocity'then return
'Fly already disabled.'end b:flyStop()return'Fly disabled.'end local d=c.
Executor.Character if not d then return"You don't have a character."end b.
character=d if b.flying and b.method=='velocity'then b:flyStop()return
'Fly disabled.'end b:flyMethod'velocity'return'Fly enabled.'end}end function a.
az()local c=a.cache.az if not c then c={c=b()}a.cache.az=c end return c.c end
end do local b=function()local b=a.V()return{Name='flyspeed',Aliases={'flysp'},
Description='Get or set fly speed. Usage: flyspeed <speed>',Group='DefaultDebug'
,Args={{Type='number',Name='speed',Description='Fly speed',Optional=true}},
ClientRun=function(c,d)if d then b:setSpeed(d)return('Fly speed set to %d.'):
format(d)end local e=b.method=='cframe'and b.cFlySpeed or b.method=='vehicle'and
b.vehicleFlySpeed or b.flySpeed return('Current fly speed: %d (%s).'):format(e,b
.method)end}end function a.aA()local c=a.cache.aA if not c then c={c=b()}a.cache
.aA=c end return c.c end end do local b=function()local b=a.a()local c,d=(b.
RunService)return{Name='fov',Aliases={},Description=
'Set a custom FOV. Resets when toggled off.',Group='DefaultDebug',Args={{Type=
'number',Name='value',Description='FOV value (e.g. 120) or blank to toggle off',
Optional=true}},ClientRun=function(e,f)if not f or f<=0 then if d then d:
Disconnect()d=nil end return'FOV override disabled.'end if d then d:Disconnect()
end d=c.RenderStepped:Connect(function()local g=workspace.CurrentCamera if g
then g.FieldOfView=f end end)return('FOV set to %d.'):format(f)end}end function
a.aB()local c=a.cache.aB if not c then c={c=b()}a.cache.aB=c end return c.c end
end do local b=function()local b=a.a()local c,d,e,f,g,h=b.Players,b.RunService,{
}return{Name='fps',Aliases={'fpscounter'},InverseAliases={'unfps'},Description=
'Toggle FPS counter overlay.',Group='DefaultDebug',Args={},ClientRun=function(i)
if i:isInvertedCall()then if not f then return'FPS counter already disabled.'end
if h then h:Disconnect()h=nil end f:Destroy()f=nil g=nil return
'FPS counter disabled.'end if f then if h then h:Disconnect()h=nil end f:
Destroy()f=nil g=nil return'FPS counter disabled.'end f=Instance.new'ScreenGui'f
.Name='CoCoFPS'f.ResetOnSpawn=false f.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
g=Instance.new'TextLabel'g.Size=UDim2.new(0,100,0,30)g.Position=UDim2.new(1,-110
,0,5)g.BackgroundColor3=Color3.new(0,0,0)g.BackgroundTransparency=0.5 g.
TextColor3=Color3.new(0,1,0)g.TextScaled=true g.Font=Enum.Font.Code g.Text=
'FPS: --'g.Parent=f f.Parent=pcall(gethui)and gethui()or c.LocalPlayer:
WaitForChild'PlayerGui'local j=tick()h=d.RenderStepped:Connect(function()local l
=tick()local m=l-j j=l table.insert(e,m)if#e>30 then table.remove(e,1)end local
n=0 for o,p in ipairs(e)do n=n+p end local o=n/#e local p=o>0 and math.floor(1/o
)or 0 g.Text=('FPS: %d'):format(p)end)return'FPS counter enabled.'end}end
function a.aC()local c=a.cache.aC if not c then c={c=b()}a.cache.aC=c end return
c.c end end do local b=function()local b=a.a()local c,d,e,f,g=b.UserInputService
,b.RunService,game:GetService'ContextActionService',Enum.ContextActionPriority.
High.Value,{}g.__index=g function g.new(h,i)local j=setmetatable({},g)j.f=h j.p=
i j.v=i*0 return j end function g:Update(h,i)local j,l,m=self.f*2*math.pi,self.p
,self.v local n,o=i-l,math.exp(-j*h)local p,q=i+(m*h-n*(j*h+1))*o,(j*h*(n*j-m)+m
)*o self.p=p self.v=q return p end function g:Reset(h)self.p=h self.v=h*0 end
local h={running=false,camera=workspace.CurrentCamera,cameraPos=Vector3.new(),
cameraRot=Vector2.new(),cameraFov=70,navSpeed=1,keyboard={W=0,A=0,S=0,D=0,E=0,Q=
0,Up=0,Down=0},mouseDelta=Vector2.new(),velSpring=g.new(5,Vector3.new()),
panSpring=g.new(5,Vector2.new()),playerState={cameraType=nil,cameraCFrame=nil,
cameraFocus=nil,cameraFieldOfView=nil,mouseBehavior=nil,mouseIconEnabled=nil}}
workspace:GetPropertyChangedSignal'CurrentCamera':Connect(function()local i=
workspace.CurrentCamera if i then h.camera=i end end)local i=function(i)local j,
l=h.camera,0.1 local m,n=j.ViewportSize,h.cameraFov local o=2*math.tan(math.rad(
n)/2)local p,q,r,s,t,u=m.x/m.y*o,i.RightVector,i.UpVector,i.LookVector,Vector3.
new(),512 for v=0,1,0.5 do for w=0,1,0.5 do local x,y=(v-0.5)*p,(w-0.5)*o local
z=q*x-r*y+s local A=i.p+z*l local B,C=workspace:FindPartOnRay(Ray.new(A,z.unit*u
))local D=(C-A).Magnitude if u>D then u=D t=z.unit end end end return s:Dot(t)*u
end local j,l=function(j)local l=h l.navSpeed=math.clamp(l.navSpeed+j*(l.
keyboard.Up-l.keyboard.Down)*0.75,0.01,4)local m,n=Vector3.new(l.keyboard.D-l.
keyboard.A,l.keyboard.E-l.keyboard.Q,l.keyboard.S-l.keyboard.W)*Vector3.new(1,1,
1),c:IsKeyDown(Enum.KeyCode.LeftShift)local o,p=l.velSpring:Update(j,m*(l.
navSpeed*(n and 0.25 or 1))),l.mouseDelta*Vector2.new(1,1)*(math.pi/64)l.
mouseDelta=Vector2.new()local q,r=l.panSpring:Update(j,p),math.sqrt(math.tan(
math.rad(35))/math.tan(math.rad(l.cameraFov/2)))l.cameraRot=l.cameraRot+q*
Vector2.new(0.75,1)*8*(j/r)l.cameraRot=Vector2.new(math.clamp(l.cameraRot.x,-
math.rad(90),math.rad(90)),l.cameraRot.y%(2*math.pi))local s=CFrame.new(l.
cameraPos)*CFrame.fromOrientation(l.cameraRot.x,l.cameraRot.y,0)*CFrame.new(o*
Vector3.new(1,1,1)*64*j)l.cameraPos=s.p local t=l.camera t.CFrame=s t.Focus=s*
CFrame.new(0,0,-i(s))t.FieldOfView=l.cameraFov end,function()local j=h e:
UnbindAction'FreecamKeyboard'e:UnbindAction'FreecamMousePan'd:
UnbindFromRenderStep'Freecam'j.navSpeed=1 for l in j.keyboard do j.keyboard[l]=0
end j.mouseDelta=Vector2.new()local l,m=j.playerState,j.camera m.FieldOfView=70
m.CameraType=l.cameraType m.CFrame=l.cameraCFrame m.Focus=l.cameraFocus c.
MouseIconEnabled=l.mouseIconEnabled c.MouseBehavior=l.mouseBehavior j.running=
false end return{Name='freecam',Aliases={'fc'},InverseAliases={'unfreecam',
'nofreecam'},Description=
[[Toggle freecam (WASD/QE move, Up/Down speed, Shift slow, mouse look).]],Group=
'DefaultDebug',Args={},ClientRun=function(m)local n=h if m:isInvertedCall()then
if not n.running then return'Freecam already disabled.'end l()return
'Freecam disabled.'end if n.running then l()return'Freecam disabled.'end local o
,p=n.camera,n.playerState p.cameraFieldOfView=o.FieldOfView p.cameraType=o.
CameraType p.cameraCFrame=o.CFrame p.cameraFocus=o.Focus p.mouseIconEnabled=c.
MouseIconEnabled p.mouseBehavior=c.MouseBehavior local q=o.CFrame n.cameraRot=
Vector2.new()n.cameraPos=q.p n.cameraFov=p.cameraFieldOfView n.navSpeed=1 for r
in n.keyboard do n.keyboard[r]=0 end n.mouseDelta=Vector2.new()n.velSpring:
Reset(Vector3.new())n.panSpring:Reset(Vector2.new())o.FieldOfView=70 o.
CameraType=Enum.CameraType.Custom c.MouseIconEnabled=true c.MouseBehavior=Enum.
MouseBehavior.Default e:BindActionAtPriority('FreecamKeyboard',function(r,s,t)n.
keyboard[t.KeyCode.Name]=s==Enum.UserInputState.Begin and 1 or 0 return Enum.
ContextActionResult.Sink end,false,f,Enum.KeyCode.W,Enum.KeyCode.A,Enum.KeyCode.
S,Enum.KeyCode.D,Enum.KeyCode.E,Enum.KeyCode.Q,Enum.KeyCode.Up,Enum.KeyCode.Down
)e:BindActionAtPriority('FreecamMousePan',function(r,s,t)local u=t.Delta n.
mouseDelta=Vector2.new(-u.Y,-u.X)return Enum.ContextActionResult.Sink end,false,
f,Enum.UserInputType.MouseMovement)d:BindToRenderStep('Freecam',Enum.
RenderPriority.Camera.Value,j)n.running=true return'Freecam enabled.'end}end
function a.aD()local c=a.cache.aD if not c then c={c=b()}a.cache.aD=c end return
c.c end end do local b=function()local b,c=a.a(),{}return{Name='freeze',Aliases=
{'fr'},Description='Toggle freeze a player (anchors all their parts).',Group=
'DefaultDebug',Args={{Type='player',Name='target',Description=
'The player to freeze/thaw'}},ClientRun=function(d,e)local f=e.Character if not
f then return'Target has no character.'end if c[e]then for g,h in ipairs(f:
GetDescendants())do if h:IsA'BasePart'and h.Anchored then h.Anchored=false end
end c[e]=nil return('%s thawed.'):format(e.Name)else for g,h in ipairs(f:
GetDescendants())do if h:IsA'BasePart'and not h.Anchored then h.Anchored=true
end end c[e]=true return('%s frozen.'):format(e.Name)end end}end function a.aE()
local c=a.cache.aE if not c then c={c=b()}a.cache.aE=c end return c.c end end do
local b=function()local b=a.a()local c,d,e,f=b.Lighting,b.RunService,{}local g=
function()if f then f:Disconnect()f=nil end c.Brightness=e.Brightness or 1 c.
ClockTime=e.ClockTime or 14 c.FogEnd=e.FogEnd or 100000 c.GlobalShadows=e.
GlobalShadows c.OutdoorAmbient=e.OutdoorAmbient or Color3.new(0,0,0)end return{
Name='fullbright',Aliases={'fb','fullbrightness'},InverseAliases={'unfullbright'
},Description='Toggle fullbright (max brightness, no shadows).',Group=
'DefaultDebug',Args={},ClientRun=function(h)if h:isInvertedCall()then if not f
then return'Fullbright already disabled.'end g()return'Fullbright disabled.'end
if f then g()return'Fullbright disabled.'end e.Brightness=c.Brightness e.
ClockTime=c.ClockTime e.FogEnd=c.FogEnd e.GlobalShadows=c.GlobalShadows e.
OutdoorAmbient=c.OutdoorAmbient local i=function()c.Brightness=2 c.ClockTime=14
c.FogEnd=100000 c.GlobalShadows=false c.OutdoorAmbient=Color3.fromRGB(128,128,
128)end i()f=d.RenderStepped:Connect(i)return'Fullbright enabled.'end}end
function a.aF()local c=a.cache.aF if not c then c={c=b()}a.cache.aF=c end return
c.c end end do local b=function()local b=a.a()local c=b.Lighting return{Name=
'globalshadows',Aliases={'gshadows'},InverseAliases={'unglobalshadows',
'nogshadows'},Description='Toggle global shadows.',Group='DefaultDebug',Args={},
ClientRun=function(d)if d:isInvertedCall()then if not c.GlobalShadows then
return'Global shadows already disabled.'end c.GlobalShadows=false return
'Global shadows disabled.'end c.GlobalShadows=not c.GlobalShadows return c.
GlobalShadows and'Global shadows enabled.'or'Global shadows disabled.'end}end
function a.aG()local c=a.cache.aG if not c then c={c=b()}a.cache.aG=c end return
c.c end end do local b=function()local b,c=false local d=function(d)if c then
local e=d.Executor.Character if e then local f=e:FindFirstChildWhichIsA
'Humanoid'if f then f:Destroy()end c.Parent=e d.Executor.Character=e local g=
workspace.CurrentCamera g.CameraSubject=c g.CFrame=g.CFrame local h=e:
FindFirstChild'Animate'if h then h.Disabled=true task.wait()h.Disabled=false end
end end b=false c=nil end return{Name='god',Aliases={},InverseAliases={'ungod'},
Description='Toggle god mode (invincible, disable death states).',Group=
'DefaultDebug',Args={},ClientRun=function(e)if e:isInvertedCall()then if not b
then return'God mode already disabled.'end d(e)return'God mode disabled.'end
local f=e.Executor.Character if not f then return"You don't have a character."
end if b then d(e)return'God mode disabled.'end local g=workspace.CurrentCamera
local h,i=g.CFrame,f:FindFirstChildWhichIsA'Humanoid'if not i then return
'No humanoid found.'end local j=i:Clone()j.Parent=f e.Executor.Character=nil j:
SetStateEnabled(Enum.HumanoidStateType.Dead,false)j:SetStateEnabled(Enum.
HumanoidStateType.Seated,false)j:SetStateEnabled(Enum.HumanoidStateType.
PlatformStanding,false)j.BreakJointsOnDeath=true i:Destroy()e.Executor.Character
=f g.CameraSubject=j g.CFrame=task.wait()and h j.DisplayDistanceType=Enum.
HumanoidDisplayDistanceType.None local l=f:FindFirstChild'Animate'if l then l.
Disabled=true task.wait()l.Disabled=false end j.Health=j.MaxHealth b=true c=j
return'God mode enabled.'end}end function a.aH()local c=a.cache.aH if not c then
c={c=b()}a.cache.aH=c end return c.c end end do local b=function()return{Name=
'goto',Aliases={'to','tp'},Description='Teleport to a player.',Group=
'DefaultDebug',Args={{Type='player',Name='target',Description=
'The player to teleport to'}},ClientRun=function(b,c)local d=b.Executor.
Character if not d then return"You don't have a character."end local e=d:
FindFirstChildWhichIsA'Humanoid'if not e then return'No humanoid found.'end
local f=c.Character if not f then return'Target has no character.'end local g=f:
FindFirstChildWhichIsA'Humanoid'if not g then return'Target has no humanoid.'end
local h=g.RootPart if not h then return'Target has no root part.'end local i=e.
RootPart if not i then return'You have no root part.'end if e.SeatPart then e.
Sit=false task.wait(0.1)end i.CFrame=h.CFrame*CFrame.new(3,1,0)return(
'Teleported to %s.'):format(c.Name)end}end function a.aI()local c=a.cache.aI if
not c then c={c=b()}a.cache.aI=c end return c.c end end do local b=function()
return{Name='grabtools',Aliases={},Description='Steal tools from a player.',
Group='DefaultDebug',Args={{Type='player',Name='target',Description=
'The player to grab tools from'}},ClientRun=function(b,c)local d=b.Executor.
Character if not d then return"You don't have a character."end local e=c.
Character if not e then return'Target has no character.'end local f=0 for g,h in
ipairs(e:GetChildren())do if h:IsA'Tool'then h.Parent=d f=f+1 end end local g=c:
FindFirstChild'Backpack'if g then for h,i in ipairs(g:GetChildren())do if i:IsA
'Tool'then i.Parent=d f=f+1 end end end return('Grabbed %d tool(s) from %s.'):
format(f,c.Name)end}end function a.aJ()local c=a.cache.aJ if not c then c={c=b()
}a.cache.aJ=c end return c.c end end do local b=function()local b return{Name=
'gravity',Aliases={'grav'},Description=
'Set workspace gravity (or toggle default).',Group='DefaultDebug',Args={{Type=
'number',Name='value',Description='Gravity value (e.g. 50, 196.2) or 0 for none'
,Default=196.2,Optional=true}},ClientRun=function(c,d)if b~=nil and(d==nil or d
==b or d==196.2)then workspace.Gravity=b b=nil return'Gravity restored.'end if b
==nil then b=workspace.Gravity end workspace.Gravity=d return(
'Gravity set to %g.'):format(d)end}end function a.aK()local c=a.cache.aK if not
c then c={c=b()}a.cache.aK=c end return c.c end end do local b=function()return{
Name='guiscale',Aliases={},Description='Set UI scale (0.5-2, default 1).',Group=
'DefaultDebug',Args={{Type='number',Name='scale',Description='Scale value',
Default=1}},ClientRun=function(b,c)c=math.clamp(c,0.5,2)local d=a.g().GuiRoot if
not d then return'No GUI root found.'end local e=d:FindFirstChild'CoCo'if not e
then return'CoCo GUI not found.'end local f=e:FindFirstChildWhichIsA'UIScale'if
not f then f=Instance.new'UIScale'f.Name='CoCoScale'f.Parent=e end f.Scale=c
return('UI scale set to %g.'):format(c)end}end function a.aL()local c=a.cache.aL
if not c then c={c=b()}a.cache.aL=c end return c.c end end do local b=function()
return{Name='headsit',Aliases={},Description="Sit on a player's head.",Group=
'DefaultDebug',Args={{Type='player',Name='target',Description=
'The player to sit on'}},ClientRun=function(b,c)local d=b.Executor.Character if
not d then return"You don't have a character."end local e=d:
FindFirstChildWhichIsA'Humanoid'if not e then return'No humanoid found.'end
local f=e.RootPart if not f then return'No root part.'end local g=c.Character if
not g then return'Target has no character.'end local h=g:FindFirstChild'Head'if
not h then return'Target has no head.'end f.CFrame=h.CFrame*CFrame.new(0,2,0)e.
Sit=true return("Sitting on %s's head."):format(c.Name)end}end function a.aM()
local c=a.cache.aM if not c then c={c=b()}a.cache.aM=c end return c.c end end do
local b=function()return{Name='headsize',Aliases={},Description=
'Set your head size (1-10).',Group='DefaultDebug',Args={{Type='number',Name=
'size',Description='Head size (default: 1)',Default=1}},ClientRun=function(b,c)
local d=b.Executor.Character if not d then return"You don't have a character."
end local e=d:FindFirstChild'Head'if not e then return'No head found.'end c=math
.clamp(c,0.1,10)e.Size=Vector3.new(c,c,c)return('Head size set to %g.'):format(c
)end}end function a.aN()local c=a.cache.aN if not c then c={c=b()}a.cache.aN=c
end return c.c end end do local b=function()return{Name='headthrow',Aliases={},
Description="Launch your character's head as a physics projectile.",Group=
'DefaultDebug',Args={},ClientRun=function(b)local c=b.Executor.Character if not
c then return"You don't have a character."end local d=c:FindFirstChild'Head'if
not d then return'No head found.'end local e=workspace.CurrentCamera local f=e.
CFrame.LookVector*200 d.Velocity=f d:BreakJoints()return'Head thrown.'end}end
function a.aO()local c=a.cache.aO if not c then c={c=b()}a.cache.aO=c end return
c.c end end do local b=function()return{Name='hipheight',Aliases={'hheight'},
Description="Set your character's HipHeight. Usage: hipheight <number>",Group=
'DefaultDebug',Args={{Type='number',Name='height',Description='HipHeight value'}
},ClientRun=function(b,c)local d=b.Executor.Character if not d then return
"You don't have a character."end local e=d:FindFirstChildWhichIsA'Humanoid'if
not e then return'No humanoid found.'end e.HipHeight=c return(
'HipHeight set to %s.'):format(tostring(c))end}end function a.aP()local c=a.
cache.aP if not c then c={c=b()}a.cache.aP=c end return c.c end end do local b=
function()local b=a.a()local c,d,e=b.UserInputService,false return{Name=
'infjump',Aliases={'infinitejump'},InverseAliases={'uninfjump','noinfjump'},
Description='Toggle infinite jump.',Group='DefaultDebug',Args={},ClientRun=
function(f)if f:isInvertedCall()then if not e then return
'Infinite jump already disabled.'end e:Disconnect()e=nil d=false return
'Infinite jump disabled.'end if e then e:Disconnect()e=nil d=false return
'Infinite jump disabled.'end e=c.JumpRequest:Connect(function()if d then return
end d=true local g=f.Executor.Character if g then local h=g:
FindFirstChildWhichIsA'Humanoid'if h then h:ChangeState(Enum.HumanoidStateType.
Jumping)end end task.wait()d=false end)return'Infinite jump enabled.'end}end
function a.aQ()local c=a.cache.aQ if not c then c={c=b()}a.cache.aQ=c end return
c.c end end do local b=function()local b=a.a()local c=b.Players return{Name=
'inspect',Aliases={},Description=
"Inspect properties of the object you're looking at.",Group='DefaultDebug',Args=
{},ClientRun=function()local d=c.LocalPlayer:GetMouse()local e=d.Target if not e
then return'No object targeted.'end local f={Name=e.Name,Class=e.ClassName,
Parent=e.Parent and e.Parent:GetFullName()or'nil'}return(
'Name: %s | Class: %s | Parent: %s'):format(f.Name,f.Class,f.Parent)end}end
function a.aR()local c=a.cache.aR if not c then c={c=b()}a.cache.aR=c end return
c.c end end do local b=function()local b=a.a()local c,d,e=b.Lighting,b.
RunService,{running=false,character=nil,invisChar=nil,invisFix=nil,invisDied=nil
,pos=nil,camPos=nil}local f=function(f)if e.invisFix then e.invisFix:Disconnect(
)e.invisFix=nil end if e.invisDied then e.invisDied:Disconnect()e.invisDied=nil
end local g,h,i=e.character,e.invisChar,f.Executor if g and h then local j=h:
FindFirstChildWhichIsA'Humanoid'local l=j and j.RootPart local m=l and l.CFrame
g.HumanoidRootPart.CFrame=m or g.HumanoidRootPart.CFrame h:Destroy()i.Character=
g g.Parent=workspace end e.running=false e.character=nil e.invisChar=nil e.pos=
nil e.camPos=nil end return{Name='invisible',Aliases={'invis'},InverseAliases={
'visible','vis','uninvisible'},Description=
[[Toggle invisible (clone to Lighting, make original transparent).]],Group=
'DefaultDebug',Args={},ClientRun=function(g)if g:isInvertedCall()then if not e.
running then return'Already visible.'end f(g)return'Visible.'end if e.running
then f(g)return'Invisible disabled.'end local h=g.Executor local i=h.Character
if not i then return"You don't have a character."end i.Archivable=true local j=i
:Clone()j.Parent=c j.Name=''for l,m in ipairs(j:GetDescendants())do if m:IsA
'BasePart'then if m.Name=='HumanoidRootPart'then m.Transparency=1 else m.
Transparency=0.5 end end end local l=workspace.FallenPartsDestroyHeight local m=
d.Stepped:Connect(function()pcall(function()local m=h.Character and h.Character:
FindFirstChildWhichIsA'Humanoid'if not m then return end local n=m.RootPart if
not n then return end local o,p=n.Position.Y,tostring(l):find'-'if(p and o<=l)or
(not p and o>=l)then respawnFunc()end end)end)local n=function()if not e.running
then return end if not e.character then return end local n,o,p=e.character,e.
invisChar,g.Executor if m then m:Disconnect()m=nil end if invisDied then
invisDied:Disconnect()invisDied=nil end n.Parent=workspace local q=n:
FindFirstChildWhichIsA'Humanoid'if q then q:Destroy()end p.Character=n n:
BreakJoints()e.running=false e.character=nil e.invisChar=nil end local o,p,q=j:
FindFirstChildWhichIsA'Humanoid'.Died:Connect(function()n()end),workspace.
CurrentCamera.CFrame,i.HumanoidRootPart.CFrame i:MoveTo(Vector3.new(0,math.pi*
1000000,0))task.wait(0.2)i.Parent=c j.Parent=workspace j:FindFirstChildWhichIsA
'Humanoid'.RootPart.CFrame=q h.Character=j local r=workspace.CurrentCamera r.
CameraType=Enum.CameraType.Custom r.CFrame=p local s=h.Character:FindFirstChild
'Animate'if s then s.Disabled=true task.wait()s.Disabled=false end e.running=
true e.character=i e.invisChar=j e.invisFix=m e.invisDied=o return
'Invisible enabled.'end}end function a.aS()local c=a.cache.aS if not c then c={c
=b()}a.cache.aS=c end return c.c end end do local b=function()return{Name=
'jobid',Aliases={},Description='Copy the current job ID to clipboard.',Group=
'DefaultDebug',Args={},ClientRun=function()local b=pcall(setclipboard,game.JobId
)if b then return('Job ID copied: %s'):format(game.JobId)end return('Job ID: %s'
):format(game.JobId)end}end function a.aT()local c=a.cache.aT if not c then c={c
=b()}a.cache.aT=c end return c.c end end do local b=function()return{Name=
'joindate',Aliases={'jd'},Description=
'Show the join date of a player. Usage: joindate <player>',Group='DefaultDebug',
Args={{Type='player',Name='target',Description='The player to check'}},ClientRun
=function(b,c)local d=c.AccountAge*24*60*60 local e=os.date('%m/%d/%y',os.time()
-d)b:reply(('%s joined: %s'):format(c.Name,e))return("Checked %s's join date."):
format(c.Name)end}end function a.aU()local c=a.cache.aU if not c then c={c=b()}a
.cache.aU=c end return c.c end end do local b=function()return{Name='jump',
Aliases={},Description='Force your character to jump.',Group='DefaultDebug',Args
={},ClientRun=function(b)local c=b.Executor.Character if not c then return
"You don't have a character."end local d=c:FindFirstChildWhichIsA'Humanoid'if
not d then return'No humanoid found.'end d:ChangeState(Enum.HumanoidStateType.
Jumping)return'Jumped.'end}end function a.aV()local c=a.cache.aV if not c then c
={c=b()}a.cache.aV=c end return c.c end end do local b=function()return{Name=
'jumppower',Aliases={'jp','jpower'},Description=
'Set your jump power or jump height.',Group='DefaultDebug',Args={{Type='number',
Name='power',Description='The jump power/height to set (default: 50)',Default=50
}},ClientRun=function(b,c)local d=b.Executor.Character if not d then return
"You don't have a character."end local e=d:FindFirstChildWhichIsA'Humanoid'if
not e then return'No humanoid found.'end if e.UseJumpPower then e.JumpPower=c
else e.JumpHeight=c end return('Jump power set to %d.'):format(c)end}end
function a.aW()local c=a.cache.aW if not c then c={c=b()}a.cache.aW=c end return
c.c end end do local b=function()return{Name='lay',Aliases={'laydown'},
Description='Lay your character down.',Group='DefaultDebug',Args={},ClientRun=
function(b)local c=b.Executor.Character if not c then return
"You don't have a character."end local d=c:FindFirstChildWhichIsA'Humanoid'if
not d then return'No humanoid found.'end d.Sit=true task.wait(0.1)local e=d.
RootPart if e then e.CFrame=e.CFrame*CFrame.Angles(math.pi*0.5,0,0)end for f,g
in ipairs(d:GetPlayingAnimationTracks())do g:Stop()end return'Lay enabled.'end}
end function a.aX()local c=a.cache.aX if not c then c={c=b()}a.cache.aX=c end
return c.c end end do local b=function()return{Name='light',Aliases={},
Description='Attach a light to your character.',Group='DefaultDebug',Args={},
ClientRun=function(b)local c=b.Executor.Character if not c then return
"You don't have a character."end local d=c:FindFirstChild'Head'if not d then
return'No head found.'end local e=d:FindFirstChild'CharLight'if e then e:
Destroy()return'Light removed.'end local f=Instance.new'PointLight'f.Name=
'CharLight'f.Brightness=3 f.Range=15 f.Color=Color3.new(1,1,1)f.Parent=d return
'Light attached.'end}end function a.aY()local c=a.cache.aY if not c then c={c=b(
)}a.cache.aY=c end return c.c end end do local b=function()return{Name='lookat',
Aliases={},Description='Point your camera at a player.',Group='DefaultDebug',
Args={{Type='player',Name='target',Description='The player to look at'}},
ClientRun=function(b,c)local d=c.Character if not d then return
'Target has no character.'end local e=d:FindFirstChild'Head'if not e then return
'Target has no head.'end local f=workspace.CurrentCamera f.CFrame=CFrame.lookAt(
f.CFrame.p,e.Position)return('Looking at %s.'):format(c.Name)end}end function a.
aZ()local c=a.cache.aZ if not c then c={c=b()}a.cache.aZ=c end return c.c end
end do local b=function()local b=a.a()local c,d,e=(b.RunService)return{Name=
'loopanimation',Aliases={'loopanim'},Description=
'Toggle looping an animation by ID.',Group='DefaultDebug',Args={{Type='string',
Name='id',Description='Animation ID to loop',Optional=true}},ClientRun=function(
f,g)if d then d:Disconnect()d=nil e=nil return'Animation loop stopped.'end local
h=f.Executor.Character if not h then return"You don't have a character."end
local i=h:FindFirstChildWhichIsA'Humanoid'if not i then return
'No humanoid found.'end local j=g and g:match'(%d+)'if not j then return
'Invalid animation ID.'end e=j d=c.RenderStepped:Connect(function()local l=f.
Executor.Character if not l then return end local m=l:FindFirstChildWhichIsA
'Humanoid'if not m then return end local n=false for o,p in ipairs(m:
GetPlayingAnimationTracks())do if p.Animation.AnimationId:match(e)then n=true
break end end if not n then local o=Instance.new'Animation'o.AnimationId=
'rbxassetid://'..e local p=m:LoadAnimation(o)p:Play()end end)return(
'Looping animation %s.'):format(j)end}end function a.a_()local c=a.cache.a_ if
not c then c={c=b()}a.cache.a_=c end return c.c end end do local b=function()
local b=a.a()local c,d=(b.RunService)return{Name='loopgoto',Aliases={},
InverseAliases={'unloopgoto','noloopgoto'},Description=
'Continuously teleport to a player every frame.',Group='DefaultDebug',Args={{
Type='player',Name='target',Description='The player to follow',Optional=true}},
ClientRun=function(e,f)if e:isInvertedCall()then if not d then return
'Loop-goto already disabled.'end d:Disconnect()d=nil return'Loop-goto stopped.'
end if d then d:Disconnect()d=nil return'Loop-goto stopped.'end if not f then
return'Usage: loopgoto <player>'end local g=e.Executor.Character if not g then
return"You don't have a character."end local h=g:FindFirstChildWhichIsA
'Humanoid'if not h then return'No humanoid found.'end local i=h.RootPart if not
i then return'No root part.'end d=c.RenderStepped:Connect(function()local j=f.
Character if not j then return end local l=j:FindFirstChildWhichIsA'Humanoid'if
not l then return end local m=l.RootPart if not m then return end local n=e.
Executor.Character if not n then return end local o=n:FindFirstChildWhichIsA
'Humanoid'if not o then return end local p=o.RootPart if not p then return end p
.CFrame=m.CFrame*CFrame.new(0,3,0)end)return('Now loop-goto %s.'):format(f.Name)
end}end function a.a0()local c=a.cache.a0 if not c then c={c=b()}a.cache.a0=c
end return c.c end end do local b=function()return{Name='maxzoom',Aliases={},
Description='Set the camera max zoom distance. Usage: maxzoom <distance>',Group=
'DefaultDebug',Args={{Type='number',Name='distance',Description=
'Max zoom distance (default 99999)',Optional=true}},ClientRun=function(b,c)c=c
or 99999 b.Executor.CameraMaxZoomDistance=c return('Max zoom set to %s.'):
format(tostring(c))end}end function a.a1()local c=a.cache.a1 if not c then c={c=
b()}a.cache.a1=c end return c.c end end do local b=function()local b=a.a()local
c=b.Lighting return{Name='night',Aliases={},Description=
'Set lighting to nighttime.',Group='DefaultDebug',Args={},ClientRun=function()c.
ClockTime=0 return'Time set to night (0:00).'end}end function a.a2()local c=a.
cache.a2 if not c then c={c=b()}a.cache.a2=c end return c.c end end do local b=
function()return{Name='nilchar',Aliases={},Description=
'Despawn your character without triggering respawn.',Group='DefaultDebug',Args={
},ClientRun=function(b)local c=b.Executor.Character if not c then return
"You don't have a character."end local d=c:FindFirstChildWhichIsA'Humanoid'if d
then d:Destroy()end c:Destroy()return"Character nil'd."end}end function a.a3()
local c=a.cache.a3 if not c then c={c=b()}a.cache.a3=c end return c.c end end do
local b=function()return{Name='noanim',Aliases={},Description=
'Toggle disabling all character animations.',Group='DefaultDebug',Args={},
ClientRun=function(b)local c=b.Executor.Character if not c then return
"You don't have a character."end local d=c:FindFirstChild'Animate'if not d then
return'No Animate script found.'end d.Disabled=not d.Disabled return d.Disabled
and'Animations disabled.'or'Animations enabled.'end}end function a.a4()local c=a
.cache.a4 if not c then c={c=b()}a.cache.a4=c end return c.c end end do local b=
function()return{Name='nobgui',Aliases={'rohg','nobillboardgui','noname'},
Description=[[Remove all BillboardGuis and SurfaceGuis from your character.]],
Group='DefaultDebug',Args={},ClientRun=function(b)local c=b.Executor.Character
if not c then return"You don't have a character."end local d=0 for e,f in
ipairs(c:GetDescendants())do if f:IsA'BillboardGui'or f:IsA'SurfaceGui'then f:
Destroy()d=d+1 end end return('Removed %d GUI(s).'):format(d)end}end function a.
a5()local c=a.cache.a5 if not c then c={c=b()}a.cache.a5=c end return c.c end
end do local b=function()local b=a.a()local c,d=(b.RunService)return{Name=
'noclip',Aliases={'nc'},InverseAliases={'clip','unnoclip'},Description=
'Toggle noclip (walk through walls).',Group='DefaultDebug',Args={},ClientRun=
function(e)if e:isInvertedCall()then if not d then return
'Noclip already disabled.'end d:Disconnect()d=nil return'Noclip disabled.'end if
d then d:Disconnect()d=nil return'Noclip disabled.'end d=c.Stepped:Connect(
function()local f=e.Executor.Character if not f then return end for g,h in
ipairs(f:GetDescendants())do if h:IsA'BasePart'then h.CanCollide=false end end
end)return'Noclip enabled.'end}end function a.a6()local c=a.cache.a6 if not c
then c={c=b()}a.cache.a6=c end return c.c end end do local b=function()local b=a
.a()local c,d=(b.Lighting)return{Name='nofog',Aliases={},InverseAliases={'fog'},
Description='Toggle removing all fog.',Group='DefaultDebug',Args={},ClientRun=
function(e)if e:isInvertedCall()then if not d then return'Fog already restored.'
end c.FogEnd=d d=nil return'Fog restored.'end if d then c.FogEnd=d d=nil return
'Fog restored.'end d=c.FogEnd c.FogEnd=math.huge return'Fog removed.'end}end
function a.a7()local c=a.cache.a7 if not c then c={c=b()}a.cache.a7=c end return
c.c end end do local b=function()return{Name='nolimbs',Aliases={'rlimbs'},
Description='Remove all character limbs.',Group='DefaultDebug',Args={},ClientRun
=function(b)local c=b.Executor.Character if not c then return
"You don't have a character."end local d=0 for e,f in ipairs(c:GetChildren())do
if f:IsA'BasePart'and f.Name~='Head'then f:Destroy()d=d+1 end end return d>0 and
('Removed %d limb(s).'):format(d)or'No limbs found.'end}end function a.a8()local
c=a.cache.a8 if not c then c={c=b()}a.cache.a8=c end return c.c end end do local
b=function()local b=false return{Name='nosit',Aliases={},InverseAliases={
'unnosit'},Description='Toggle disable seated state.',Group='DefaultDebug',Args=
{},ClientRun=function(c)local d=c.Executor.Character if not d then return
"You don't have a character."end local e=d:FindFirstChildWhichIsA'Humanoid'if
not e then return'No humanoid found.'end if c:isInvertedCall()then if not b then
return'Sitting already enabled.'end b=false e:SetStateEnabled(Enum.
HumanoidStateType.Seated,true)return'Seated state enabled.'end b=not b e:
SetStateEnabled(Enum.HumanoidStateType.Seated,not b)return b and
'Seated state disabled.'or'Seated state enabled.'end}end function a.a9()local c=
a.cache.a9 if not c then c={c=b()}a.cache.a9=c end return c.c end end do local b
=function()return{Name='notools',Aliases={'rtools'},Description=
'Remove all tools from your character.',Group='DefaultDebug',Args={},ClientRun=
function(b)local c=b.Executor.Character if not c then return
"You don't have a character."end local d=0 for e,f in ipairs(c:GetChildren())do
if f:IsA'Tool'then f:Destroy()d=d+1 end end local e=b.Executor:FindFirstChild
'Backpack'if e then for f,g in ipairs(e:GetChildren())do if g:IsA'Tool'then g:
Destroy()d=d+1 end end end return('Removed %d tool(s).'):format(d)end}end
function a.ba()local c=a.cache.ba if not c then c={c=b()}a.cache.ba=c end return
c.c end end do local b=function()return{Name='offset',Aliases={},Description=
'Teleport with offset from a player.',Group='DefaultDebug',Args={{Type='player',
Name='target',Description='The player to offset from'},{Type='number',Name='x',
Description='X offset',Default=5},{Type='number',Name='y',Description='Y offset'
,Default=0},{Type='number',Name='z',Description='Z offset',Default=0}},ClientRun
=function(b,c,d,e,f)local g=b.Executor.Character if not g then return
"You don't have a character."end local h=g:FindFirstChildWhichIsA'Humanoid'if
not h then return'No humanoid found.'end local i=h.RootPart if not i then return
'No root part.'end local j=c.Character if not j then return
'Target has no character.'end local l=j:FindFirstChildWhichIsA'Humanoid'if not l
then return'Target has no humanoid.'end local m=l.RootPart if not m then return
'Target has no root part.'end i.CFrame=m.CFrame*CFrame.new(d,e,f)return(
'Teleported with offset (%g, %g, %g) from %s.'):format(d,e,f,c.Name)end}end
function a.bb()local c=a.cache.bb if not c then c={c=b()}a.cache.bb=c end return
c.c end end do local b=function()local b=a.a()local c,d,e=b.RunService,false,{}
local f=function()for f,g in ipairs(e)do g:Disconnect()end e={}d=false end
return{Name='orbit',Aliases={},InverseAliases={'unorbit'},Description=
[=[Orbit around a target player. Usage: orbit <player> [speed] [distance]]=],
Group='DefaultDebug',Args={{Type='player',Name='target',Description=
'The player to orbit around',Optional=true},{Type='number',Name='speed',
Description='Orbit speed (default 0.2)',Optional=true},{Type='number',Name=
'distance',Description='Orbit distance (default 6)',Optional=true}},ClientRun=
function(g,h,i,j)if g:isInvertedCall()then if not d then return
'Orbit already disabled.'end f()return'Orbit stopped.'end if d then f()return
'Orbit stopped.'end if not h then return'Specify a player to orbit around.'end
local l=g.Executor.Character local m=l and l:FindFirstChildWhichIsA'Humanoid'
local n=m and m.RootPart if not n then return
"You don't have a character with a root part."end local o=h.Character local p=o
and o:FindFirstChildWhichIsA'Humanoid'and o:FindFirstChildWhichIsA'Humanoid'.
RootPart if not p then return'Target has no character or root part.'end d=true i
=i or 0.2 j=j or 6 local q=0 local r,s,t,u=c.Heartbeat:Connect(function()if not
d then return end local r,s=m and m.RootPart,h.Character and h.Character:
FindFirstChildWhichIsA'Humanoid'and h.Character:FindFirstChildWhichIsA'Humanoid'
.RootPart if not r or not s then for t,u in ipairs(e)do u:Disconnect()end e={}d=
false return end q=q+i r.CFrame=CFrame.new(s.Position)*CFrame.Angles(0,math.rad(
q),0)*CFrame.new(j,0,0)end),c.RenderStepped:Connect(function()if not d then
return end local r,s=m and m.RootPart,h.Character and h.Character:
FindFirstChildWhichIsA'Humanoid'and h.Character:FindFirstChildWhichIsA'Humanoid'
.RootPart if not r or not s then return end r.CFrame=CFrame.new(r.Position,s.
Position)end),m.Died:Connect(function()for r,s in ipairs(e)do s:Disconnect()end
e={}d=false end),m.Seated:Connect(function(r)if r then for s,t in ipairs(e)do t:
Disconnect()end e={}d=false end end)e={r,s,t,u}return('Orbiting %s.'):format(h.
Name)end}end function a.bc()local c=a.cache.bc if not c then c={c=b()}a.cache.bc
=c end return c.c end end do local b=function()local b=a.a()local c,d,e,f,g=b.
PathfindingService,(b.RunService)local h=function(h)if f then f:Disconnect()f=
nil end if g then g:Disconnect()g=nil end e=nil local i=h.Executor.Character
local j=i and i:FindFirstChildWhichIsA'Humanoid'if j and j.RootPart then j:
MoveTo(j.RootPart.Position)end end return{Name='pathfind',Aliases={'pathfindto',
'pathfindfollow'},InverseAliases={'unpathfind','nopathfind'},Description=
[[Toggle pathfinding to a player (walks around obstacles). Usage: pathfind <player>]]
,Group='DefaultDebug',Args={{Type='player',Name='target',Description=
'The player to pathfind to',Optional=true}},ClientRun=function(i,j)if i:
isInvertedCall()then if not f then return'Pathfind already disabled.'end h(i)
return'Pathfind stopped.'end if f then h(i)return'Pathfind stopped.'end if not j
then return'Usage: pathfind <player>'end local l=i.Executor.Character if not l
then return"You don't have a character."end local m=l:FindFirstChildWhichIsA
'Humanoid'if not m then return'No humanoid found.'end e=j g=m.Died:Connect(
function()h(i)end)f=d.RenderStepped:Connect(function()local n=i.Executor.
Character if not n then return end local o=n:FindFirstChildWhichIsA'Humanoid'if
not o then return end local p=o.RootPart if not p then return end local q=e.
Character if not q then return end local r=q:FindFirstChildWhichIsA'Humanoid'if
not r then return end local s=r.RootPart if not s then return end local t=c:
CreatePath{AgentRadius=2,AgentHeight=5,AgentCanJump=true}local u=pcall(function(
)t:ComputeAsync(p.Position,s.Position)end)if u and t.Status==Enum.PathStatus.
Success then local v=t:GetWaypoints()if#v>0 then o:MoveTo(v[math.min(#v,2)].
Position)end end end)return('Now pathfinding to %s.'):format(j.Name)end}end
function a.bd()local c=a.cache.bd if not c then c={c=b()}a.cache.bd=c end return
c.c end end do local b=function()return{Name='ping',Aliases={'notifyping'},
Description='Display your network ping.',Group='DefaultDebug',Args={},ClientRun=
function()local b=game:GetService'Stats'local c=math.floor(b.Network.
ServerStatsItem['Data Ping']:GetValue())return('Ping: %d ms'):format(c)end}end
function a.be()local c=a.cache.be if not c then c={c=b()}a.cache.be=c end return
c.c end end do local b=function()local b=a.a()local c=b.Players return{Name=
'position',Aliases={'pos'},Description=
[[Returns Vector3 position of you or other players. Empty string is the player has no character.]]
,Group='DefaultDebug',Args={{Type='player',Name='Player',Description=
[[The player to report the position of. Omit for your own position.]],Default=c.
LocalPlayer}},ClientRun=function(d,e)local f=e.Character if not f or not f:
FindFirstChild'HumanoidRootPart'then return''end return tostring(f.
HumanoidRootPart.Position):gsub('%s','')end}end function a.bf()local c=a.cache.
bf if not c then c={c=b()}a.cache.bf=c end return c.c end end do local b=
function()local b=a.V()return{Name='qefly',Aliases={'flyqe'},InverseAliases={
'unqefly','noqefly'},Description='Toggle QE up/down fly controls.',Group=
'DefaultDebug',Args={},ClientRun=function(c)if c:isInvertedCall()then if b.
keyBinds~='qe'then return'QE fly already disabled.'end b.keyBinds='default'
return'QE fly disabled.'end b.keyBinds=b.keyBinds=='qe'and'default'or'qe'return
b.keyBinds=='qe'and'QE fly enabled.'or'QE fly disabled.'end}end function a.bg()
local c=a.cache.bg if not c then c={c=b()}a.cache.bg=c end return c.c end end do
local b=function()return{Name='refresh',Aliases={'re'},Description=
'Refresh your character (respawn & restore position).',Group='DefaultDebug',Args
={},ClientRun=function(b)local c=b.Executor.Character if not c then return
"You don't have a character."end local d=c:FindFirstChildWhichIsA'Humanoid'local
e=d and d.RootPart local f,g=e and e.CFrame,workspace.CurrentCamera.CFrame if d
then d:ChangeState(Enum.HumanoidStateType.Dead)end c:ClearAllChildren()local h=
Instance.new'Model'h.Parent=workspace b.Executor.Character=h task.wait()b.
Executor.Character=c h:Destroy()task.spawn(function()local i=b.Executor.
CharacterAdded:Wait()local j=i:FindFirstChildWhichIsA'Humanoid'while not j do
task.wait()j=i:FindFirstChildWhichIsA'Humanoid'end if f then local l=j.RootPart
if l then l.CFrame=f end end workspace.CurrentCamera.CFrame=g end)return
'Refreshed.'end}end function a.bh()local c=a.cache.bh if not c then c={c=b()}a.
cache.bh=c end return c.c end end do local b=function()local b,c=a.a(),game:
GetService'TeleportService'return{Name='rejoin',Aliases={'rj'},Description=
'Rejoins the current server.',Group='DefaultDebug',Args={},ClientRun=function()
local d=b.Players.LocalPlayer if not d then return'No local player.'end c:
Teleport(game.PlaceId,d)return'Rejoining...'end}end function a.bi()local c=a.
cache.bi if not c then c={c=b()}a.cache.bi=c end return c.c end end do local b=
function()return{Name='reset',Aliases={'respawn'},Description=
'Reset your character (kill).',Group='DefaultDebug',Args={},ClientRun=function(b
)local c=b.Executor.Character if not c then return"You don't have a character."
end local d=c:FindFirstChildWhichIsA'Humanoid'if d then d:ChangeState(Enum.
HumanoidStateType.Dead)else c:BreakJoints()end return'Reset.'end}end function a.
bj()local c=a.cache.bj if not c then c={c=b()}a.cache.bj=c end return c.c end
end do local b=function()return{Name='scare',Aliases={'spook'},Description=
'Teleport behind a player briefly. Usage: scare <player>',Group='DefaultDebug',
Args={{Type='player',Name='target',Description='The player to scare'}},ClientRun
=function(b,c)local d=b.Executor.Character local e=d and d:
FindFirstChildWhichIsA'Humanoid'local f=e and e.RootPart if not f then return
"You don't have a character with a root part."end local g=c.Character local h=g
and g:FindFirstChildWhichIsA'Humanoid'local i=h and h.RootPart if not i then
return'Target has no character or root part.'end if c==b.Executor then return
"You can't scare yourself."end local j=f.CFrame f.CFrame=i.CFrame+i.CFrame.
LookVector*2 f.CFrame=CFrame.new(f.Position,i.Position)task.wait(0.5)f.CFrame=j
return('Scared %s.'):format(c.Name)end}end function a.bk()local c=a.cache.bk if
not c then c={c=b()}a.cache.bk=c end return c.c end end do local b=function()
local b,c=a.a(),game:GetService'TeleportService'local d=b.HttpService return{
Name='serverhop',Aliases={'shop','hop'},Description=
'Teleports you to another server of the same game.',Group='DefaultDebug',Args={}
,ClientRun=function()local e=b.Players.LocalPlayer if not e then return
'No local player.'end local f,g,h=game.PlaceId,game.JobId,game.GameId local i=
string.format([[https://games.roblox.com/v1/games/%d/servers/Public?limit=100]],
h)local j,l=pcall(function()return d:GetAsync(i)end)if not j then return
'Failed to fetch servers.'end local m=d:JSONDecode(l)if not m or not m.data then
return'No server data found.'end for n,o in ipairs(m.data)do if o.id~=g and o.
playing<o.maxPlayers then c:TeleportToPlaceInstance(f,o.id,e)return
'Server hopping...'end end return'No other servers available.'end}end function a
.bl()local c=a.cache.bl if not c then c={c=b()}a.cache.bl=c end return c.c end
end do local b=function()local b=a.a()local c=b.Players return{Name='serverinfo'
,Aliases={'info','sinfo'},Description=
'Show server information (players, uptime, place, etc.).',Group='DefaultDebug',
Args={},ClientRun=function(d)local e,f,g,h,i=#c:GetPlayers(),game.PlaceId,game.
JobId,game.GameId,game:GetService'Stats':FindFirstChild'PerformanceStats'local j
,l,m=i and math.floor(i:GetValue())or'N/A',game:GetService'Stats':FindFirstChild
'Session','N/A'if l then local n=l:GetValue()local o,p,q=math.floor(n/3600),math
.floor((n%3600)/60),math.floor(n%60)m=('%02d:%02d:%02d'):format(o,p,q)end d:
reply(('Players: %d | FPS: %s | Uptime: %s'):format(e,j,m))d:reply((
'Place ID: %d | Game ID: %d'):format(f,h))d:reply(('Job ID: %s'):format(g))local
n=game.CreatorId and('Creator ID: %d'):format(game.CreatorId)or''if n~=''then d:
reply(n)end return'Server info displayed.'end}end function a.bm()local c=a.cache
.bm if not c then c={c=b()}a.cache.bm=c end return c.c end end do local b=
function()local b return{Name='setfpscap',Aliases={'fpscap','maxfps'},
Description='Set a custom FPS cap. Usage: setfpscap <fps> | none',Group=
'DefaultDebug',Args={{Type='number',Name='fps',Description=
'FPS cap (e.g. 60, 144, 999)',Optional=true}},ClientRun=function(c,d)if b then
task.cancel(b)b=nil end if not d or d<=0 then return'FPS cap disabled.'end local
e=d b=task.spawn(function()local f=os.clock()while true do if os.clock()>=f+1/e
then f=os.clock()task.wait()end end end)return('FPS cap set to %d.'):format(e)
end}end function a.bn()local c=a.cache.bn if not c then c={c=b()}a.cache.bn=c
end return c.c end end do local b=function()return{Name='setwaypoint',Aliases={
'swp','saveposition','savepos'},Description=
'Save your current position as a named waypoint.',Group='DefaultDebug',Args={{
Type='string',Name='name',Description='Name for the waypoint'}},ClientRun=
function(b,c)local d=b.Executor.Character if not d then return
"You don't have a character."end local e=d:FindFirstChildWhichIsA'Humanoid'if
not e then return'No humanoid.'end local f=e.RootPart if not f then return
'No root part.'end local g,h,i=f.Position,b:getStore'Waypoints',c:lower()h[i]={
name=c,x=math.floor(g.X),y=math.floor(g.Y),z=math.floor(g.Z)}return(
'Saved waypoint "%s" at (%d, %d, %d).'):format(c,h[i].x,h[i].y,h[i].z)end}end
function a.bo()local c=a.cache.bo if not c then c={c=b()}a.cache.bo=c end return
c.c end end do local b=function()return{Name='sit',Aliases={},Description=
'Force sit your character.',Group='DefaultDebug',Args={},ClientRun=function(b)
local c=b.Executor.Character if not c then return"You don't have a character."
end local d=c:FindFirstChildWhichIsA'Humanoid'if not d then return
'No humanoid found.'end d.Sit=true return'Sit enabled.'end}end function a.bp()
local c=a.cache.bp if not c then c={c=b()}a.cache.bp=c end return c.c end end do
local b=function()local b,c,d,e=false,{},function(b)local c=b and b:
FindFirstChildWhichIsA'Humanoid'return c and c.RigType==Enum.HumanoidRigType.R15
end return{Name='sitwalk',Aliases={},Description=
'Toggle sitwalk (all animations become sit).',Group='DefaultDebug',Args={},
ClientRun=function(f)local g=f.Executor.Character if not g then return
"You don't have a character."end local h=g:FindFirstChild'Animate'if not h then
return'No Animate script found.'end local i=h:FindFirstChild'sit'if not i then
return'No sit animation found.'end local j=i:FindFirstChildWhichIsA'Animation'if
not j then return'No sit animation ID found.'end local l=g:
FindFirstChildWhichIsA'Humanoid'if not l then return'No humanoid found.'end b=
not b local m={'idle','walk','run','jump'}if b then local n=j.AnimationId for o,
p in ipairs(m)do local q=h:FindFirstChild(p)if q then local r=q:
FindFirstChildWhichIsA'Animation'if r then c[p]=r.AnimationId r.AnimationId=n
end end end e=l.HipHeight l.HipHeight=d(g)and 0.5 or-1.5 return
'Sitwalk enabled.'end for n,o in ipairs(m)do local p=h:FindFirstChild(o)if p
then local q=p:FindFirstChildWhichIsA'Animation'if q and c[o]then q.AnimationId=
c[o]end end end if e then l.HipHeight=e e=nil end return'Sitwalk disabled.'end}
end function a.bq()local c=a.cache.bq if not c then c={c=b()}a.cache.bq=c end
return c.c end end do local b=function()local b=a.a()local c,d,e=(b.RunService)
local f=function()if d then d:Disconnect()d=nil end if e then e:Disconnect()e=
nil end end return{Name='spasm',Aliases={},InverseAliases={'unspasm','nospasm'},
Description='Toggle character spasm.',Group='DefaultDebug',Args={},ClientRun=
function(g)if g:isInvertedCall()then if not d then return
'Spasm already disabled.'end f()return'Spasm disabled.'end if d then f()return
'Spasm disabled.'end local h=g.Executor.Character if not h then return
"You don't have a character."end local i=h:FindFirstChildWhichIsA'Humanoid'if
not i then return'No humanoid found.'end d=c.Stepped:Connect(function()local j=g
.Executor.Character if not j then return end for l,m in ipairs(j:GetChildren())
do if m:IsA'BasePart'then m.Velocity=Vector3.new(math.random(-500,500),math.
random(-500,500),math.random(-500,500))m.RotVelocity=Vector3.new(math.random(-
500,500),math.random(-500,500),math.random(-500,500))end end end)e=i.Died:
Connect(function()if d then d:Disconnect()d=nil end if e then e:Disconnect()e=
nil end end)return'Spasm enabled.'end}end function a.br()local c=a.cache.br if
not c then c={c=b()}a.cache.br=c end return c.c end end do local b=function()
return{Name='spawnpoint',Aliases={'spawn'},Description=
[[Set a custom spawn point at your position. Run again to clear.]],Group=
'DefaultDebug',Args={},ClientRun=function(b)local c=b.Executor.Character if not
c then return"You don't have a character."end local d=c:FindFirstChildWhichIsA
'Humanoid'if not d then return'No humanoid found.'end local e=d.RootPart if not
e then return'No root part.'end local f=c:FindFirstChild'CustomSpawn'if f then f
:Destroy()return'Custom spawn point cleared.'end local g=Instance.new
'CFrameValue'g.Name='CustomSpawn'g.Value=e.CFrame g.Parent=c b.Executor.
CharacterAdded:Connect(function(h)local i=h:FindFirstChild'CustomSpawn'if not i
then return end task.wait(0.2)local j=h:FindFirstChildWhichIsA'Humanoid'j=j and
j.RootPart if j then j.CFrame=i.Value end end)return'Custom spawn point set.'end
}end function a.bs()local c=a.cache.bs if not c then c={c=b()}a.cache.bs=c end
return c.c end end do local b=function()return{Name='spin',Aliases={},
InverseAliases={'unspin'},Description=
'Toggle spin your character (optional: speed).',Group='DefaultDebug',Args={{Type
='number',Name='speed',Description='Spin speed (default: 20)',Default=20,
Optional=true}},ClientRun=function(b,c)local d=b.Executor.Character if not d
then return"You don't have a character."end local e=d:FindFirstChildWhichIsA
'Humanoid'if not e then return'No humanoid found.'end local f=e.RootPart if not
f then return'No root part found.'end local g for h,i in ipairs(f:GetChildren())
do if i.Name=='Spinning'then g=i break end end if b:isInvertedCall()then if not
g then return'Spin already disabled.'end g:Destroy()return'Spin disabled.'end if
g then g:Destroy()return'Spin disabled.'end local h=Instance.new
'BodyAngularVelocity'h.Name='Spinning'h.Parent=f h.MaxTorque=Vector3.new(0,math.
huge,0)h.AngularVelocity=Vector3.new(0,c,0)return('Spin enabled (speed: %d).'):
format(c)end}end function a.bt()local c=a.cache.bt if not c then c={c=b()}a.
cache.bt=c end return c.c end end do local b=function()local b=a.a()local c,d,e=
(b.RunService)local f=function()if e then e:Disconnect()e=nil end d=nil end
return{Name='stare',Aliases={'stareat'},InverseAliases={'unstare','nostare'},
Description='Toggle making your head face a player.',Group='DefaultDebug',Args={
{Type='player',Name='target',Description='The player to stare at',Optional=true}
},ClientRun=function(g,h)if g:isInvertedCall()then if not e then return
'Not staring at anyone.'end f()return'Stare disabled.'end if e or not h then f()
return'Stare disabled.'end local i=g.Executor.Character if not i then return
"You don't have a character."end local j=i:FindFirstChild'Head'if not j then
return'No head found.'end d=h e=c.RenderStepped:Connect(function()local l=g.
Executor.Character if not l then return end local m=l:FindFirstChild'Head'if not
m then return end local n=d.Character if not n then return end local o=n:
FindFirstChild'Head'if not o then return end m.CFrame=CFrame.lookAt(m.Position,o
.Position)end)return('Now staring at %s.'):format(h.Name)end}end function a.bu()
local c=a.cache.bu if not c then c={c=b()}a.cache.bu=c end return c.c end end do
local b=function()return{Name='stopanimations',Aliases={'stopanims','stopanim'},
Description='Stop all playing animations.',Group='DefaultDebug',Args={},
ClientRun=function(b)local c=b.Executor.Character if not c then return
"You don't have a character."end local d=c:FindFirstChildWhichIsA'Humanoid'if
not d then return'No humanoid found.'end local e=0 for f,g in ipairs(d:
GetPlayingAnimationTracks())do g:Stop()e=e+1 end return(
'Stopped %d animation(s).'):format(e)end}end function a.bv()local c=a.cache.bv
if not c then c={c=b()}a.cache.bv=c end return c.c end end do local b=function()
return{Name='stun',Aliases={'platformstand'},InverseAliases={'unstun','nostun'},
Description='Toggle stun (platform stand).',Group='DefaultDebug',Args={},
ClientRun=function(b)local c=b.Executor.Character if not c then return
"You don't have a character."end local d=c:FindFirstChildWhichIsA'Humanoid'if
not d then return'No humanoid found.'end if b:isInvertedCall()then if not d.
PlatformStand then return'Already unstunned.'end d.PlatformStand=false return
'Unstunned.'end d.PlatformStand=not d.PlatformStand return d.PlatformStand and
'Stunned.'or'Unstunned.'end}end function a.bw()local c=a.cache.bw if not c then
c={c=b()}a.cache.bw=c end return c.c end end do local b=function()local b=a.a()
local c,d,e=b.RunService,false return{Name='teleportwalk',Aliases={'tpwalk'},
InverseAliases={'unteleportwalk','untpwalk'},Description=
[=[Toggle teleport walk (rubberband as you move). Usage: teleportwalk [speed]]=]
,Group='DefaultDebug',Args={{Type='number',Name='speed',Description=
'Teleport speed (default 1)',Optional=true}},ClientRun=function(f,g)if f:
isInvertedCall()then if not d then return'Teleport walk already disabled.'end if
e then e:Disconnect()e=nil end d=false return'Teleport walk disabled.'end if d
then if e then e:Disconnect()e=nil end d=false return'Teleport walk disabled.'
end local h=f.Executor.Character local i=h and h:FindFirstChildWhichIsA
'Humanoid'if not i then return'No humanoid found.'end d=true g=g or 1 e=c.
Heartbeat:Connect(function(j)if not d then return end local l=f.Executor.
Character local m=l and l:FindFirstChildWhichIsA'Humanoid'if not(l and m and m.
Parent)then e:Disconnect()e=nil d=false return end if m.MoveDirection.Magnitude>
0 then l:TranslateBy(m.MoveDirection*g*j*10)end end)return(
'Teleport walk enabled (speed: %s).'):format(tostring(g))end}end function a.bx()
local c=a.cache.bx if not c then c={c=b()}a.cache.bx=c end return c.c end end do
local b=function()return{Name='thirdp',Aliases={},Description=
'Force third-person camera.',Group='DefaultDebug',Args={},ClientRun=function(b)
local c,d=workspace.CurrentCamera,b.Executor.Character c.CameraType=Enum.
CameraType.Custom if d then local e=d:FindFirstChildWhichIsA'Humanoid'if e then
c.CameraSubject=e end end b.Executor.CameraMode=Enum.CameraMode.Classic return
'Third-person enabled.'end}end function a.by()local c=a.cache.by if not c then c
={c=b()}a.cache.by=c end return c.c end end do local b=function()return{Name=
'thru',Aliases={'t','through'},Description=
[[Teleports you through whatever your mouse is hovering over, placing you equidistantly from the wall.]]
,Group='DefaultDebug',Args={{Type='number',Name='Extra distance',Description=
'Go through the wall an additional X studs.',Default=0}},ClientRun=function(b,c)
local d,e=b.Executor:GetMouse(),b.Executor.Character if not e or not e:
FindFirstChild'HumanoidRootPart'then return"You don't have a character."end
local f=e.HumanoidRootPart.Position local g=(d.Hit.p-f)e:MoveTo((g*2)+(g.unit*c)
+f)return'Blinked!'end}end function a.bz()local c=a.cache.bz if not c then c={c=
b()}a.cache.bz=c end return c.c end end do local b=function()local b=a.a()local
c=b.Lighting return{Name='time',Aliases={},Description=
[[Set local time of day. Usage: time <0-24|morning|day|noon|night|midnight>]],
Group='DefaultDebug',Args={{Type='string',Name='time',Description=
'Time value (0-24) or preset'}},ClientRun=function(d,e)local f={morning=6,day=12
,noon=12,night=0,midnight=0}local g=f[e:lower()]or tonumber(e)if not g then
return[[Invalid time. Use 0-24 or: morning, day, noon, night, midnight.]]end g=
math.clamp(g,0,24)c.ClockTime=g return('Time set to %g:00.'):format(g)end}end
function a.bA()local c=a.cache.bA if not c then c={c=b()}a.cache.bA=c end return
c.c end end do local b=function()local b=a.a()local c,d=b.Lighting,game:
GetService'ReplicatedStorage'return{Name='tools',Aliases={'gears'},Description=
[[Copy tools from Lighting and ReplicatedStorage into your backpack.]],Group=
'DefaultDebug',Args={},ClientRun=function(e)local f=e.Executor:
FindFirstChildWhichIsA'Backpack'if not f then return'No backpack found.'end
local g=0 local function h(i)for j,l in ipairs(i:GetChildren())do if l:IsA'Tool'
or l:IsA'HopperBin'then l:Clone().Parent=f g=g+1 end h(l)end end h(c)h(d)return(
'Copied %d tools from Lighting and ReplicatedStorage.'):format(g)end}end
function a.bB()local c=a.cache.bB if not c then c={c=b()}a.cache.bB=c end return
c.c end end do local b=function()return{Name='touchinterests',Aliases={},
Description='Fire TouchInterest on the part under your mouse.',Group=
'DefaultDebug',Args={},ClientRun=function()local b=game:GetService'Players'.
LocalPlayer local c=b.Character if not c then return
"You don't have a character."end local d=c:FindFirstChildWhichIsA'Humanoid'if
not d then return'No humanoid.'end local e=d.RootPart if not e then return
'No root part.'end if not firetouchinterest then return
'Your exploit does not support firetouchinterest.'end local f=b:GetMouse()local
g=f.Target if not g then return'No target under mouse.'end local h=0 for i,j in
ipairs(g:GetDescendants())do if j:IsA'TouchTransmitter'or j.ClassName==
'TouchInterest'then local l=j.FindFirstAncestorWhichIsA and j:
FindFirstAncestorWhichIsA'Part'or j:FindFirstAncestorOfClass'Part'if l then
firetouchinterest(l,e,0)task.wait()firetouchinterest(l,e,1)h=h+1 end end end
return('Fired %d touch interest(s).'):format(h)end}end function a.bC()local c=a.
cache.bC if not c then c={c=b()}a.cache.bC=c end return c.c end end do local b=
function()return{Name='tpposition',Aliases={'tppos'},Description=
'Teleport to X Y Z coordinates.',Group='DefaultDebug',Args={{Type='number',Name=
'x',Description='X coordinate'},{Type='number',Name='y',Description=
'Y coordinate'},{Type='number',Name='z',Description='Z coordinate'}},ClientRun=
function(b,c,d,e)local f=b.Executor.Character if not f then return
"You don't have a character."end local g=f:FindFirstChildWhichIsA'Humanoid'if
not g then return'No humanoid found.'end local h=g.RootPart if not h then return
'No root part.'end h.CFrame=CFrame.new(c,d,e)return(
'Teleported to (%.0f, %.0f, %.0f).'):format(c,d,e)end}end function a.bD()local c
=a.cache.bD if not c then c={c=b()}a.cache.bD=c end return c.c end end do local
b=function()local b=a.a()local c=b.UserInputService return{Name='tptool',Aliases
={'teleporttool'},Description='Give yourself a teleport tool.',Group=
'DefaultDebug',Args={},ClientRun=function(d)local e=d.Executor local f=e:
FindFirstChildWhichIsA'Backpack'if not f then return'No backpack found.'end
local g=Instance.new'Tool'g.Name='Teleport Tool'g.RequiresHandle=false g.Parent=
f g.Activated:Connect(function()local h=e.Character local i=h and h:
FindFirstChildWhichIsA'Humanoid'local j=i and i.RootPart if not j then return
end local l,m=workspace.CurrentCamera,c:GetMouseLocation()local n=l:
ViewportPointToRay(m.X,m.Y)local o=workspace:Raycast(n.Origin,n.Direction*1000)
local p=o and o.Position or n.Origin+n.Direction*1000 j.CFrame=CFrame.new(p.X,p.
Y+3,p.Z)*CFrame.fromOrientation(j.CFrame:ToOrientation())j.Velocity=Vector3.zero
j.RotVelocity=Vector3.zero end)return'Teleport tool given.'end}end function a.bE
()local c=a.cache.bE if not c then c={c=b()}a.cache.bE=c end return c.c end end
do local b=function()return{Name='trip',Aliases={},Description=
'Make your character trip.',Group='DefaultDebug',Args={},ClientRun=function(b)
local c=b.Executor.Character if not c then return"You don't have a character."
end local d=c:FindFirstChildWhichIsA'Humanoid'local e=d and d.RootPart if not d
or not e then return'No humanoid or root part.'end d:ChangeState(Enum.
HumanoidStateType.FallingDown)e.Velocity=e.CFrame.LookVector*30 return'Tripped.'
end}end function a.bF()local c=a.cache.bF if not c then c={c=b()}a.cache.bF=c
end return c.c end end do local b=function()local b=a.a()local c=b.TweenService
return{Name='tweengoto',Aliases={'tgoto','tto','tweento','ttp'},Description=
'Tween to a player. Usage: tweengoto <player> [speed]',Group='DefaultDebug',Args
={{Type='player',Name='target',Description='The player to tween to'},{Type=
'number',Name='speed',Description='Tween speed in seconds (default 1)',Optional=
true}},ClientRun=function(d,e,f)local g=d.Executor.Character local h=g and g:
FindFirstChildWhichIsA'Humanoid'local i=h and h.RootPart if not i then return
"You don't have a root part."end local j=e.Character local l=j and j:
FindFirstChild'HumanoidRootPart'if not l then return
'Target has no humanoid root part.'end f=f or 1 local m=c:Create(i,TweenInfo.
new(f,Enum.EasingStyle.Linear),{CFrame=l.CFrame*CFrame.new(0,3,0)})m:Play()
return('Tweening to %s.'):format(e.Name)end}end function a.bG()local c=a.cache.
bG if not c then c={c=b()}a.cache.bG=c end return c.c end end do local b=
function()return{Name='userid',Aliases={'id'},Description=
"Show a player's user ID. Usage: userid <player>",Group='DefaultDebug',Args={{
Type='player',Name='target',Description='The player to check'}},ClientRun=
function(b,c)b:reply(("%s's user ID: %d"):format(c.Name,c.UserId))return(
"Checked %s's user ID."):format(c.Name)end}end function a.bH()local c=a.cache.bH
if not c then c={c=b()}a.cache.bH=c end return c.c end end do local b=function()
return{Name='vehiclegoto',Aliases={'vgoto','vtp'},Description=
"Teleport to a player's vehicle seat.",Group='DefaultDebug',Args={{Type='player'
,Name='target',Description='The player whose vehicle to teleport to'}},ClientRun
=function(b,c)local d=b.Executor.Character if not d then return
"You don't have a character."end local e=d:FindFirstChildWhichIsA'Humanoid'if
not e then return'No humanoid found.'end local f=e.RootPart if not f then return
'No root part.'end local g=c.Character if not g then return
'Target has no character.'end local h for i,j in ipairs(g:GetDescendants())do if
j:IsA'VehicleSeat'then h=j break end end if not h then for i,j in ipairs(
workspace:GetDescendants())do if j:IsA'VehicleSeat'then local l=j:FindFirstChild
'Occupant'if l and l.Value and l.Value.Parent==g then h=j break end end end end
if not h then if g:FindFirstChildWhichIsA'Humanoid'then local i=g:
FindFirstChildWhichIsA'Humanoid'local j=i.RootPart if j then f.CFrame=j.CFrame*
CFrame.new(5,0,0)return('Teleported near %s.'):format(c.Name)end end return
'No vehicle seat found.'end f.CFrame=h.CFrame*CFrame.new(0,3,0)return(
"Teleported to %s's vehicle."):format(c.Name)end}end function a.bI()local c=a.
cache.bI if not c then c={c=b()}a.cache.bI=c end return c.c end end do local b=
function()return{Name='version',Args={},Description=
'Shows the current version of CoCo',Group='DefaultDebug',Run=function()return(
'CoCo Version %s'):format(_P.vers)end}end function a.bJ()local c=a.cache.bJ if
not c then c={c=b()}a.cache.bJ=c end return c.c end end do local b=function()
local b=a.V()return{Name='vfly',Aliases={'vehiclefly'},InverseAliases={'unvfly',
'novehiclefly'},Description='Toggle vehicle fly.',Group='DefaultDebug',Args={},
ClientRun=function(c)if c:isInvertedCall()then if not b.flying or b.method~=
'vehicle'then return'Vehicle fly already disabled.'end b:flyStop()b.method=
'velocity'return'Vehicle fly disabled.'end local d=c.Executor.Character if not d
then return"You don't have a character."end b.character=d if b.flying and b.
method=='vehicle'then b:flyStop()b.method='velocity'return
'Vehicle fly disabled.'end b:flyMethod'vehicle'return'Vehicle fly enabled.'end}
end function a.bK()local c=a.cache.bK if not c then c={c=b()}a.cache.bK=c end
return c.c end end do local b=function()local b,c,d,e=nil,nil,nil,(a.a())local f
=function(f)if c then c:Disconnect()c=nil end if d then d:Disconnect()d=nil end
local g,h=workspace.CurrentCamera,f.Executor.Character if h then local i=h:
FindFirstChildWhichIsA'Humanoid'if i then g.CameraSubject=i end end g.CameraType
=Enum.CameraType.Custom b=nil end return{Name='view',Aliases={'spectate'},
InverseAliases={'unview','unspectate'},Description=
'Toggle spectate a player (see through their eyes).',Group='DefaultDebug',Args={
{Type='player',Name='target',Description='The player to spectate',Optional=true}
},ClientRun=function(g,h)if g:isInvertedCall()then if not b then return
'Not spectating anyone.'end f(g)return'Spectate stopped.'end if not h or b then
f(g)return'Spectate stopped.'end local i=h.Character if not i then return
'Target has no character.'end b=h local j=workspace.CurrentCamera j.
CameraSubject=i if c then c:Disconnect()end if d then d:Disconnect()end c=h.
CharacterAdded:Connect(function()repeat task.wait()until h.Character and h.
Character:FindFirstChildWhichIsA'Humanoid'local l=h.Character:
FindFirstChildWhichIsA'Humanoid'if l then j.CameraSubject=l end end)d=j:
GetPropertyChangedSignal'CameraSubject':Connect(function()if b and b.Character
then local l=b.Character:FindFirstChildWhichIsA'Humanoid'if l then j.
CameraSubject=l end end end)return('Now spectating %s.'):format(h.Name)end}end
function a.bL()local c=a.cache.bL if not c then c={c=b()}a.cache.bL=c end return
c.c end end do local b=function()local b=a.a()local c,d,e=(b.Players)return{Name
='viewpart',Aliases={'viewp'},Description='Spectate a part by its name.',Group=
'DefaultDebug',Args={{Type='string',Name='partName',Description=
'Name of the part to spectate',Optional=true}},ClientRun=function(f,g)if d or
not g then if e then e:Disconnect()e=nil end local h,i=workspace.CurrentCamera,c
.LocalPlayer local j=i.Character if j then local l=j:FindFirstChildWhichIsA
'Humanoid'if l then h.CameraSubject=l end end h.CameraType=Enum.CameraType.
Custom d=nil return'Part spectate stopped.'end local h={}for i,j in ipairs(
workspace:GetDescendants())do if j:IsA'BasePart'and j.Name:lower()==g:lower()
then table.insert(h,j)end end if#h==0 then return('No part named %q found.'):
format(g)end local i=h[1]if#h>1 then local j=workspace.CurrentCamera local l,m=j
.CFrame.p,h[1]local n=(m.Position-l).Magnitude for o=2,#h do local p=(h[o].
Position-l).Magnitude if p<n then m=h[o]n=p end end i=m end d=i local j=
workspace.CurrentCamera j.CameraType=Enum.CameraType.Attach j.CameraSubject=i if
e then e:Disconnect()end e=i.AncestryChanged:Connect(function()if not i.Parent
then local l=c.LocalPlayer local m=l.Character if m then local n=m:
FindFirstChildWhichIsA'Humanoid'if n then j.CameraSubject=n end end j.CameraType
=Enum.CameraType.Custom d=nil e=nil end end)return('Now spectating %s.'):format(
i:GetFullName())end}end function a.bM()local c=a.cache.bM if not c then c={c=b()
}a.cache.bM=c end return c.c end end do local b=function()return{Name=
'walkspeed',Aliases={'ws','speed'},Description='Set your walkspeed.',Group=
'DefaultDebug',Args={{Type='number',Name='speed',Description=
'The walkspeed to set (default: 16)',Default=16}},ClientRun=function(b,c)local d
=b.Executor.Character if not d then return"You don't have a character."end local
e=d:FindFirstChildWhichIsA'Humanoid'if not e then return'No humanoid found.'end
e.WalkSpeed=c return('Walkspeed set to %d.'):format(c)end}end function a.bN()
local c=a.cache.bN if not c then c={c=b()}a.cache.bN=c end return c.c end end do
local b=function()local b=a.a()local c,d=(b.RunService)return{Name='walkto',
Aliases={'follow'},InverseAliases={'unwalkto','unfollow','nowalkto'},Description
='Auto-walk toward a player.',Group='DefaultDebug',Args={{Type='player',Name=
'target',Description='The player to walk toward',Optional=true}},ClientRun=
function(e,f)if e:isInvertedCall()then if not d then return
'Walk-to already disabled.'end d:Disconnect()d=nil return'Walk-to stopped.'end
if d then d:Disconnect()d=nil return'Walk-to stopped.'end if not f then return
'Usage: walkto <player>'end local g=e.Executor.Character if not g then return
"You don't have a character."end local h=g:FindFirstChildWhichIsA'Humanoid'if
not h then return'No humanoid found.'end d=c.RenderStepped:Connect(function()
local i=e.Executor.Character if not i then return end local j=i:
FindFirstChildWhichIsA'Humanoid'if not j then return end local l=f.Character if
not l then return end local m=l:FindFirstChildWhichIsA'Humanoid'if not m then
return end local n=m.RootPart if not n then return end j:MoveTo(n.Position)end)
return('Now walking to %s.'):format(f.Name)end}end function a.bO()local c=a.
cache.bO if not c then c={c=b()}a.cache.bO=c end return c.c end end do local b=
function()return{Name='walktopos',Aliases={'walktoposition'},Description=
[[Walk your character to specific coordinates. Usage: walktopos <x> <y> <z>]],
Group='DefaultDebug',Args={{Type='number',Name='x',Description='X coordinate'},{
Type='number',Name='y',Description='Y coordinate'},{Type='number',Name='z',
Description='Z coordinate'}},ClientRun=function(b,c,d,e)local f=b.Executor.
Character if not f then return"You don't have a character."end local g=f:
FindFirstChildWhichIsA'Humanoid'if not g then return'No humanoid found.'end g:
MoveTo(Vector3.new(c,d,e))return('Walking to (%g, %g, %g).'):format(c,d,e)end}
end function a.bP()local c=a.cache.bP if not c then c={c=b()}a.cache.bP=c end
return c.c end end do local b=function()return{Name='waypoint',Aliases={'wp',
'loadposition','loadpos'},Description='Teleport to a saved waypoint.',Group=
'DefaultDebug',Args={{Type={Transform=function(b)return b end,Validate=function(
b)return b~=nil end,Parse=function(b)return tostring(b)end,Autocomplete=function
(b,c)local d,e=c.Registry:getStore'Waypoints',{}for f,g in pairs(d)do table.
insert(e,g.name)end return e end},Name='name',Description='Name of the waypoint'
}},ClientRun=function(b,c)local d=b.Executor.Character if not d then return
"You don't have a character."end local e=d:FindFirstChildWhichIsA'Humanoid'if
not e then return'No humanoid.'end local f=e.RootPart if not f then return
'No root part.'end local g=b:getStore'Waypoints'local h=g[c:lower()]if not h
then return('Waypoint "%s" not found.'):format(c)end f.CFrame=CFrame.new(h.x,h.y
,h.z)return('Teleported to waypoint "%s" (%d, %d, %d).'):format(h.name,h.x,h.y,h
.z)end}end function a.bQ()local c=a.cache.bQ if not c then c={c=b()}a.cache.bQ=c
end return c.c end end do local b=function()local b,c=false,function(b)for c,d
in ipairs(workspace:GetDescendants())do if d:IsA'BasePart'and not d.Parent:
FindFirstChildWhichIsA'Humanoid'and not(d.Parent.Parent and d.Parent.Parent:
FindFirstChildWhichIsA'Humanoid')then d.LocalTransparencyModifier=b and 0.5 or 0
end end end return{Name='xray',Aliases={},InverseAliases={'unxray','noxray'},
Description='Toggle x-ray (see through walls).',Group='DefaultDebug',Args={},
ClientRun=function(d)if d:isInvertedCall()then if not b then return
'X-ray already disabled.'end b=false c(false)return'X-ray disabled.'end b=not b
c(b)return b and'X-ray enabled.'or'X-ray disabled.'end}end function a.bR()local
c=a.cache.bR if not c then c={c=b()}a.cache.bR=c end return c.c end end do local
b=function()return{Name='remotespy',Aliases={'rspy','cobalt'},Description=
"Run the 'Cobalt' remote spy.",Group='DefaultScripts',Args={},ClientRun=function
(b,c)loadstring(game:HttpGet
[[https://raw.githubusercontent.com/Panda-Utilities/Storage/refs/heads/main/Cobalt.luau]]
)()return'Executed Cobalt'end}end function a.bS()local c=a.cache.bS if not c
then c={c=b()}a.cache.bS=c end return c.c end end do local b=function()return{
Name='dex',Aliases={'dex++','dexplusplus'},Description=
"Run the 'Dex++' version of Dex.",Group='DefaultScripts',Args={},ClientRun=
function(b,c)loadstring(game:HttpGet
[[https://raw.githubusercontent.com/Panda-Utilities/Storage/refs/heads/main/Dex%2B%2B.lua]]
)()return'Executed Dex++'end}end function a.bT()local c=a.cache.bT if not c then
c={c=b()}a.cache.bT=c end return c.c end end do local b=function()return{Name=
'synsaveinstance',Aliases={'saveinstance','save','download'},Description=
'Run SynSaveInstance.',Group='DefaultScripts',Args={},ClientRun=function(b,c)
loadstring(game:HttpGet
[[https://raw.githubusercontent.com/Panda-Utilities/Storage/refs/heads/main/SaveInstance.lua]]
)()return'Executed SynSaveInstance'end}end function a.bU()local c=a.cache.bU if
not c then c={c=b()}a.cache.bU=c end return c.c end end do local b=function()
local b,c=a.H(),a.g()return{Name='scriptblox',Aliases={'sb','sblox'},Description
=
[[Search and run scripts from ScriptBlox. Autocomplete shows matching scripts as you type.]]
,Group='DefaultUtil',Args={{Type='scriptblox',Name='query',Description=
'Search query or script name'}},ClientRun=function(d,e)local f=e and e:match
'^%s*(.-)%s*$'or e if not f or f==''then return
'Usage: scriptblox <search query>'end local g=b.getCachedScript(f)if g then
return b.runScript(d,g)end local h,i,j=f,f:match'^(.*)%s([^%s]+)$'if i and j and
j:match'^[0-9a-fA-F]{8,}$'then local l=b.findScriptByPartialId(j)if l then
return b.runScript(d,l)end local m,n=pcall(b.searchScripts,j)if m and n and n.
scripts and#n.scripts>0 then local o=n.scripts[1]b.cacheScript(j,o)return b.
runScript(d,o)end h=i end local l,m,n=pcall(b.searchScripts,h)if not l then
return string.format('ScriptBlox search threw an error for %q: %s',h,tostring(m)
)end if not m then local o=n=='bad_response'and'bad response'or n==
'parse_failed'and'failed to parse response'or'request failed'return string.
format('ScriptBlox API error for %q (%s).',h,o)end local o=m.scripts if not o or
#o==0 then return string.format('No scripts found matching %q.',h)end for p,q in
ipairs(o)do if q.title and q.title:lower()==h:lower()then return b.runScript(d,q
)end end if#o==1 then return b.runScript(d,o[1])end d:reply(string.format(
'=== ScriptBlox Results (%d found) ===',#o),c.Colors.TextAccent)d:reply(b.
formatResult(o),c.Colors.TextPrimary)d:reply(
[[Tip: Refine your query to get a single result and it will run automatically.]]
,c.Colors.TextSecondary)return string.format(
'Showing %d results for %q. Refine your search.',#o,h)end}end function a.bV()
local c=a.cache.bV if not c then c={c=b()}a.cache.bV=c end return c.c end end do
local b=function()local b,c,d,e=a.c(),{},function(b)return(b:gsub('\\%$',
'___!CMDR_DOLLAR!___'))end,function(b)return(b:gsub('___!CMDR_DOLLAR!___','$'))
end function c.runCommandString(f,g)g=b.parseEscapeSequences(g)g=b.
encodeEscapedOperators(g)local h,i=g:split'&&',''for j,l in ipairs(h)do local m=
i:gsub('%$','\\x24'):gsub('%%','%%%%')l=l:gsub('||',i:find'%s'and('%q'):format(m
)or m)i=tostring(f:evaluateAndRun((c.runEmbeddedCommands(f,l))))if j==#h then
return i end end end function c.runEmbeddedCommands(f,g)g=d(g)local h={}for i in
g:gmatch'$(%b{})'do local j,l=true,i:sub(2,#i-1)if l:match'^{.+}$'then j=false l
=l:sub(2,#l-1)end h[i]=c.runCommandString(f,l)if j then if h[i]:find'%s'or h[i]
==''then h[i]=string.format('%q',h[i])end end end return e(g:gsub('$(%b{})',h))
end function c.substituteArgs(f,g)f=d(f)if type(g)=='table'then local h={}for i=
1,#g do local j,l=g[i],tostring(i)h[l]=j if j:find'%s'then h[l]=string.format(
'%q',j)end end g=h end return e(f:gsub('($%d+)%b{}','%1'):gsub('$(%w+)',g))end
function c.makeAliasCommand(f,g)local h,i=unpack(f:split'|')local j={}g=b.
encodeEscapedOperators(g)local l={}for m in g:gmatch'$(%d+)'do if l[m]==nil then
l[m]=true local n,o,p,q,r=(g:match(`${m}(%b\{})`))if n then n=n:sub(2,#n-1)p,q,r
=unpack(n:split'|')end o=p and not not p:match'%?$'p=if p then p:match'^%w+'else
'string'q=q or`Argument {m}`r=r or''table.insert(j,{Type=p,Name=q,Description=r,
Optional=o})end end return{Name=h,Aliases={},Description=`<Alias> {i or g}`,
Group='UserAlias',Args=j,Run=function(m)return c.runCommandString(m.Dispatcher,c
.substituteArgs(g,m.RawArguments))end}end return c end function a.bW()local c=a.
cache.bW if not c then c={c=b()}a.cache.bW=c end return c.c end end do local b=
function()local b=a.bW()return{Name='alias',Aliases={},Description=
[[Creates a new, single command out of a command and given arguments.]],Group=
'DefaultUtil',Args={{Type='string',Name='Alias name',Description=
"The key or input type you'd like to bind the command to."},{Type='string',Name=
'Command string',Description=
[[The command text you want to run. Separate multiple commands with "&&". Accept arguments with $1, $2, $3, etc.]]
}},ClientRun=function(c,d,e)c.CoCo.Registry:registerCommandObject(b.
makeAliasCommand(d,e),true)return('Created alias %q'):format(d)end}end function
a.bX()local c=a.cache.bX if not c then c={c=b()}a.cache.bX=c end return c.c end
end do local b=function()local b,c=a.bW(),a.a()local d=c.UserInputService local
e=function(e)if not e then e={}end local f,g,h=d:IsKeyDown(Enum.KeyCode.
LeftControl),d:IsKeyDown(Enum.KeyCode.RightControl),e[Enum.KeyCode.LeftControl]
==true or e[Enum.KeyCode.RightControl]==true if h~=(f or g)then return false end
f=d:IsKeyDown(Enum.KeyCode.LeftShift)g=d:IsKeyDown(Enum.KeyCode.RightShift)local
i=e[Enum.KeyCode.LeftShift]==true or e[Enum.KeyCode.RightShift]==true if i~=(f
or g)then return false end f=d:IsKeyDown(Enum.KeyCode.LeftAlt)g=d:IsKeyDown(Enum
.KeyCode.RightAlt)local j=e[Enum.KeyCode.LeftAlt]==true or e[Enum.KeyCode.
RightAlt]==true if j~=(f or g)then return false end return true end return{Name=
'bind',Aliases={},Description=
[[Binds a command to a key combination. Modes: toggle, hold. Use 'bind list' to see all binds.]]
,Group='DefaultUtil',Args={{Type='keycombo',Name='Combo',Description=
[[Key combination (e.g. F2, Ctrl+F). Type 'list' to show all binds.]]},{Type=
'command',Name='Command',Description='The command to run',Optional=true},{Type=
'string',Name='Arguments',Description=
[[Arguments for the command. Append ' hold' for hold-to-repeat mode.]],Default=
''}},ClientRun=function(f,g,h,i)local j,l=f:getStore'COCO_Binds',f.RawArguments
if not l or#l==0 then return
'Usage: bind <combo> <command> [args...]\n  bind list           \u{2014} show all binds\n  bind F2 fly         \u{2014} fire "fly" on F2\n  bind Ctrl+Shift+F fly speed 100 hold  \u{2014} hold mode'
end if l[1]:lower()=='list'then local m=0 for n,o in pairs(j)do if type(o)==
'table'and o.mode then m=m+1 f:reply(('%s  [%s]  %s %s'):format(n,o.mode or
'toggle',o.command or'',o.args or''))end end if m==0 then return
'No binds active.'end return('%d bind(s) active.'):format(m)end if not g then
return'Invalid key combination.'end if not h then return(
'%s is not currently bound.'):format(g.text)end local m,n=i or'','toggle'local o
=m:match'(%S+)$'if o=='hold'then n=o m=#m>#o and m:sub(1,#m-#o-1)or''end local p
,q=g.text,h..' '..m local r=j[p]if r and r.connections then for s,t in ipairs(r.
connections)do t:Disconnect()end end local s,t=function()local s=f.Dispatcher:
evaluateAndRun(b.runEmbeddedCommands(f.Dispatcher,q))if s then f:reply(tostring(
s))end end,{}if n=='toggle'then local u=true t[1]=d.InputBegan:Connect(function(
v,w)if w then return end if v.KeyCode~=g.key then return end if not u then
return end if not e(g.modifiers)then return end u=false s()end)t[#t+1]=d.
InputEnded:Connect(function(v)if v.KeyCode==g.key then u=true end end)elseif n==
'hold'then t[1]=d.InputBegan:Connect(function(u,v)if v then return end if u.
KeyCode~=g.key then return end if not e(g.modifiers)then return end s()end)t[#t+
1]=d.InputEnded:Connect(function(u)if u.KeyCode==g.key then s()end end)end j[p]=
{mode=n,key=g.key,modifiers=g.modifiers,command=h,args=m,connections=t}return(
'Bound %q \u{2192} [%s] %s %s'):format(p,n,h,m)end}end function a.bY()local c=a.
cache.bY if not c then c={c=b()}a.cache.bY=c end return c.c end end do local b=
function()return{Name='clear',Aliases={},Description=
'Clear all lines above the entry line of the CoCo window.',Group='DefaultUtil',
Args={},ClientRun=function()local b=pcall(gethui)and gethui():FindFirstChild
'CoCo'if not b then return''end local c=b:FindFirstChild'Frame'if c then local d
=c:FindFirstChild'Line'for e,f in pairs(c:GetChildren())do if f~=d and f.Name==
'Line'and f:IsA'TextBox'then f:Destroy()end end end return''end}end function a.
bZ()local c=a.cache.bZ if not c then c={c=b()}a.cache.bZ=c end return c.c end
end do local b=function()return{Name='date',Aliases={'timestamp'},Description=
'Convert a timestamp to a human-readable format.',Group='DefaultUtil',Args={{
Type='number',Name='timestamp',Description=
'A numerical representation of a specific moment in time.',Optional=true}},
ClientRun=function(b,c)c=c or os.time()return`{os.date('%x',c)} {os.date('%X',c)
}`end}end function a.b_()local c=a.cache.b_ if not c then c={c=b()}a.cache.b_=c
end return c.c end end do local b=function()return{Name='decode',Aliases={},
Description='Decodes a JSON Array into a comma-separated list',Group=
'DefaultUtil',Args={{Type='json',Name='JSON',Description='The JSON array.'}},
ClientRun=function(b,c)if type(c)~='table'then c={c}end return table.concat(c,
',')end}end function a.b0()local c=a.cache.b0 if not c then c={c=b()}a.cache.b0=
c end return c.c end end do local b=function()return{Name='echo',Aliases={'='},
Description='Echoes your text back to you.',Group='DefaultUtil',Args={{Type=
'string',Name='Text',Description='The text.'}},Run=function(b,c)return c end}end
function a.b1()local c=a.cache.b1 if not c then c={c=b()}a.cache.b1=c end return
c.c end end do local b=function()local b={}function b.new()local c,d={},false
return function()if d then table.insert(c,coroutine.running())coroutine.yield()
else d=true end return function()if#c>0 then coroutine.resume(table.remove(c,1))
else d=false end end end end return b end function a.b2()local c=a.cache.b2 if
not c then c={c=b()}a.cache.b2=c end return c.c end end do local b=function()
local b,c,d=a.b2(),{AnchorPoint=Vector2.new(0.5,0.5),BackgroundColor3=Color3.
fromRGB(17,17,17),BackgroundTransparency=0.05,BorderColor3=Color3.fromRGB(17,17,
17),BorderSizePixel=20,ClearTextOnFocus=false,MultiLine=true,Position=UDim2.new(
0.5,0,0.5,0),Size=UDim2.new(0.5,0,0.4,0),Font=Enum.Font.Code,TextColor3=Color3.
fromRGB(241,241,241),TextWrapped=true,TextSize=18,TextXAlignment='Left',
TextYAlignment='Top',AutoLocalize=false,PlaceholderText='Right click to exit'}
return{Name='edit',Aliases={},Description='Edit text in a TextBox',Group=
'DefaultUtil',Args={{Type='string',Name='Input text',Description=
'The text you wish to edit',Default=''},{Type='string',Name='Delimiter',
Description='The character that separates each line',Default=','}},ClientRun=
function(e,f,g)d=d or b.new()local h=d()e:reply(
'Right-click on the text area to exit.',Color3.fromRGB(158,158,158))local i=
Instance.new'ScreenGui'i.Name='CoCoEditBox'i.ResetOnSpawn=false local j=Instance
.new'TextBox'for l,m in pairs(c)do j[l]=m end j.Text=f:gsub(g,'\n')j.Parent=i i.
Parent=pcall(gethui)and gethui()or Players.LocalPlayer:WaitForChild'PlayerGui'
local l=coroutine.running()j.InputBegan:Connect(function(m)if m.UserInputType==
Enum.UserInputType.MouseButton2 then coroutine.resume(l,j.Text:gsub('\n',g))i:
Destroy()h()end end)return coroutine.yield()end}end function a.b3()local c=a.
cache.b3 if not c then c={c=b()}a.cache.b3=c end return c.c end end do local b=
function()local b=a.a()local c=b.HttpService return{Name='encode',Aliases={},
Description='Encodes a comma-separated list into a JSON array',Group=
'DefaultUtil',Args={{Type='string',Name='CSV',Description=
'The comma-separated list'}},Run=function(d,e)return c:JSONEncode(e:split',')end
}end function a.b4()local c=a.cache.b4 if not c then c={c=b()}a.cache.b4=c end
return c.c end end do local b=function()return{Name='history',Aliases={},
AutoExec={
[[alias "!|Displays previous command from history." run ${history $1{number|Line Number}}]]
,
[[alias "^|Runs the previous command, replacing all occurrences of A with B." run ${run replace ${history -1} $1{string|A} $2{string|B}}]]
,'alias "!!|Reruns the last command." ! -1'},Description=
'Displays previous commands from history.',Group='DefaultUtil',Args={{Type=
'integer',Name='Line Number',Description=
'Command line number (can be negative to go from end)'}},ClientRun=function(b,c)
local d=b.Dispatcher:getHistory()if c<=0 then c=#d+c end return d[c]or''end}end
function a.b5()local c=a.cache.b5 if not c then c={c=b()}a.cache.b5=c end return
c.c end end do local b=function()local b=a.a()local c=b.Players return{Name=
'hover',Description='Returns the name of the player you are hovering over.',
Group='DefaultUtil',Args={},ClientRun=function()local d=c.LocalPlayer:GetMouse()
local e=d.Target if not e then return''end local f=c:GetPlayerFromCharacter(e:
FindFirstAncestorOfClass'Model')return f and f.Name or''end}end function a.b6()
local c=a.cache.b6 if not c then c={c=b()}a.cache.b6=c end return c.c end end do
local b=function()return{Name='keybind',Aliases={'close','open'},Description=
'Changes the keybind used to open/close the command menu.',Group='DefaultUtil',
Args={{Type='userInput',Name='Key',Description=
'The key to bind the menu toggle to.'}},ClientRun=function(b,c)local d=b.CoCo d:
setActivationKeys{c}return('Menu keybind set to %s.'):format(c.Name or tostring(
c))end}end function a.b7()local c=a.cache.b7 if not c then c={c=b()}a.cache.b7=c
end return c.c end end do local b=function()return{Name='len',Aliases={},
Description='Returns the length of a comma-separated list',Group='DefaultUtil',
Args={{Type='string',Name='CSV',Description='The comma-separated list'}},Run=
function(b,c)return#(c:split',')end}end function a.b8()local c=a.cache.b8 if not
c then c={c=b()}a.cache.b8=c end return c.c end end do local b=function()return{
Name='math',Aliases={},Description='Perform a math operation on 2 values.',Group
='DefaultUtil',AutoExec={
[[alias "+|Perform an addition." math + $1{number|Number} $2{number|Number}]],
[[alias "-|Perform a subtraction." math - $1{number|Number} $2{number|Number}]],
[[alias "*|Perform a multiplication." math * $1{number|Number} $2{number|Number}]]
,[[alias "/|Perform a division." math / $1{number|Number} $2{number|Number}]],
[[alias "**|Perform an exponentiation." math ** $1{number|Number} $2{number|Number}]]
,[[alias "%|Perform a modulus." math % $1{number|Number} $2{number|Number}]]},
Args={{Type='mathOperator',Name='Operation',Description='A math operation.'},{
Type='number',Name='Value',Description='A number value.'},{Type='number',Name=
'Value',Description='A number value.'}},ClientRun=function(b,c,d,e)return c.
Perform(d,e)end}end function a.b9()local c=a.cache.b9 if not c then c={c=b()}a.
cache.b9=c end return c.c end end do local b=function()return{Name='pick',
Aliases={},Description='Picks a value out of a comma-separated list.',Group=
'DefaultUtil',Args={{Type='integer',Name='Index to pick',Description=
'The index of the item you want to pick'},{Type='string',Name='CSV',Description=
'The comma-separated list'}},Run=function(b,c,d)return d:split','[c]or''end}end
function a.ca()local c=a.cache.ca if not c then c={c=b()}a.cache.ca=c end return
c.c end end do local b=function()return{Name='rand',Aliases={},Description=
'Returns a random number between min and max',Group='DefaultUtil',Args={{Type=
'integer',Name='First number',Description=
[[If second number is nil, random number is between 1 and this value. If second number is provided, number is between this number and the second number.]]
},{Type='integer',Name='Second number',Description='The upper bound.',Optional=
true}},Run=function(b,c,d)return tostring(d and math.random(c,d)or math.random(c
))end}end function a.cb()local c=a.cache.cb if not c then c={c=b()}a.cache.cb=c
end return c.c end end do local b=function()return{Name='replace',Aliases={
'gsub','//'},Description='Replaces text A with text B',Group='DefaultUtil',
AutoExec={
[[alias "map|Maps a CSV into another CSV" replace $1{string|CSV} ([^,]+) "$2{string|mapped value|Use %1 to insert the element}"]]
,
[[alias "join|Joins a CSV with a specified delimiter" replace $1{string|CSV} , $2{string|Delimiter}]]
},Args={{Type='string',Name='Haystack',Description=
'The source string upon which to perform replacement.'},{Type='string',Name=
'Needle',Description='The string pattern search for.'},{Type='string',Name=
'Replacement',Description=
'The string to replace matches (%1 to insert matches).',Default=''}},Run=
function(b,c,d,e)return c:gsub(d,e)end}end function a.cc()local c=a.cache.cc if
not c then c={c=b()}a.cache.cc=c end return c.c end end do local b=function()
return{Name='resolve',Aliases={},Description=
[[Resolves Argument Value Operators into lists. E.g., resolve players * gives you a list of all players.]]
,Group='DefaultUtil',AutoExec={
'alias "me|Displays your username" resolve players .'},Args={{Type='type',Name=
'Type',Description='The type for which to resolve'},function(b)if b:getArgument(
1):Validate()==false then return end return{Type=b:getArgument(1):GetValue(),
Name='Argument Value Operator',Description=
'The value operator to resolve. One of: * ** . ? ?N, selectors (allies, enemies, friends, nearest, farthest, alive, dead, cursor, npcs), patterns (ageN, radN, groupN, #N), and +/\u{2212} set operations'
,Optional=true}end},Run=function(b)return table.concat(b:getArgument(2).
RawSegments,',')end}end function a.cd()local c=a.cache.cd if not c then c={c=b()
}a.cache.cd=c end return c.c end end do local b=function()local b=a.bW()return{
Name='run',Aliases={'>'},AutoExec={
[[alias "discard|Run a command and discard the output." replace ${run $1} .* \"\"]]
},Description='Runs a given command string (replacing embedded commands).',Group
='DefaultUtil',Args={{Type='string',Name='Command',Description=
'The command string to run'}},Run=function(c,d)return b.runCommandString(c.
Dispatcher,d)end}end function a.ce()local c=a.cache.ce if not c then c={c=b()}a.
cache.ce=c end return c.c end end do local b=function()return{Name='run-lines',
Aliases={},Description=
[[Splits input by newlines and runs each line as its own command. This is used by the init-run command.]]
,Group='DefaultUtil',Args={{Type='string',Name='Script',Description=
'The script to parse.',Default=''}},ClientRun=function(b,c)if#c==0 then return''
end local d,e=b.Dispatcher:run('var','INIT_PRINT_OUTPUT')~='',c:gsub('\n+','\n')
:split'\n'for f,g in ipairs(e)do if g:sub(1,1)=='#'then continue end local h=b.
Dispatcher:evaluateAndRun(g)if d then b:reply(h)end end return''end}end function
a.cf()local c=a.cache.cf if not c then c={c=b()}a.cache.cf=c end return c.c end
end do local b=function()local b,c=a.bW(),{startsWith=function(b,c)if b:sub(1,#c
)==c then return b:sub(#c+1)end end}return{Name='runif',Aliases={},Description=
'Runs a given command string if a certain condition is met.',Group='DefaultUtil'
,Args={{Type='conditionFunction',Name='Condition',Description=
'The condition function'},{Type='string',Name='Argument',Description=
'The argument to the condition function'},{Type='string',Name='Test against',
Description='The text to test against.'},{Type='string',Name='Command',
Description=
[[The command string to run if requirements are met. If omitted, return value from condition function is used.]]
,Optional=true}},Run=function(d,e,f,g,h)local i=c[e]if not i then return(
'Condition %q is not valid.'):format(e)end local j=i(g,f)if j then return d.
Dispatcher:evaluateAndRun(b.runEmbeddedCommands(d.Dispatcher,h or j))end return
''end}end function a.cg()local c=a.cache.cg if not c then c={c=b()}a.cache.cg=c
end return c.c end end do local b=function()return{Name='unbind',Aliases={},
Description='Unbinds a key combination previously bound with Bind.',Group=
'DefaultUtil',Args={{Type='keycombo',Name='Combo',Description=
[[The key combination to unbind (e.g. F2, Ctrl+F). Use 'bind list' to see all.]]
}},ClientRun=function(b,c)if not c then return'Invalid key combination.'end
local d,e=b:getStore'COCO_Binds',c.text local f=d[e]if f and f.connections then
for g,h in ipairs(f.connections)do h:Disconnect()end if f.heartbeat then f.
heartbeat:Disconnect()end d[e]=nil return('Unbound %q.'):format(e)end if d[c.key
]then d[c.key]:Disconnect()d[c.key]=nil return('Unbound %q.'):format(e)end
return('%q is not bound.'):format(e)end}end function a.ch()local c=a.cache.ch if
not c then c={c=b()}a.cache.ch=c end return c.c end end do local b=function()
return{Name='var',Aliases={},Description='Gets a stored variable.',Group=
'DefaultUtil',AutoExec={
[[alias "init-edit|Edit your initialization script" edit ${var init} \\
 && var= init ||]]
,
[[alias "init-run|Re-runs the initialization script manually." run-lines ${var init}]]
,'init-run'},Args={{Type='storedKey',Name='Key',Description=
[[The key to get, retrieved from your user data store. Keys prefixed with . are not saved. Keys prefixed with $ are game-wide. Keys prefixed with $. are game-wide and non-saved.]]
}},ClientRun=function(b,c)b:getStore'vars_used'[c]=true end}end function a.ci()
local c=a.cache.ci if not c then c={c=b()}a.cache.ci=c end return c.c end end do
local b=function()return{Name='var=',Aliases={},Description=
'Sets a stored value.',Group='DefaultUtil',Args={{Type='storedKey',Name='Key',
Description=
[[The key to set, saved in your user data store. Keys prefixed with . are not saved. Keys prefixed with $ are game-wide. Keys prefixed with $. are game-wide and non-saved.]]
},{Type='string',Name='Value',Description='Value or values to set.',Default=''}}
,ClientRun=function(b,c)b:getStore'vars_used'[c]=true end}end function a.cj()
local c=a.cache.cj if not c then c={c=b()}a.cache.cj=c end return c.c end end do
local b=function()local b,c,d=a.g(),
[[Argument Shorthands
-------------------
.   Me/Self
*   All/Everyone
**  Others
?   Random
?N  List of N random values
]]
,
'Tips\n----\n\u{2022} Utilize the Tab key to automatically complete commands\n\u{2022} Easily select and copy command output\n'
return{Name='help',Description=
'Displays a list of all commands, or inspects one command.',Group='Help',Args={{
Type='command',Name='Command',Description='The command to view information on',
Optional=true}},ClientRun=function(e,f)if f then local g=e.CoCo.Registry:
getCommand(f)e:reply(`Command: {g.Name}`,b.Colors.HelpOrange)if g.Aliases and#g.
Aliases>0 then e:reply(`Aliases: {table.concat(g.Aliases,', ')}`,b.Colors.
HelpGray)end if g.InverseAliases and#g.InverseAliases>0 then e:reply(`Inverse: {
table.concat(g.InverseAliases,', ')}`,b.Colors.HelpGray)end e:reply(g.
Description,b.Colors.HelpGray)for h,i in ipairs(g.Args)do e:reply(`#{h} {i.Name}{
if i.Optional==true then'?'else''}: {i.Type} - {i.Description}`)end else e:
reply(c)e:reply(d)local g=e.CoCo.Registry:getCommands()table.sort(g,function(h,i
)return if h.Group and i.Group then h.Group<i.Group else h.Group end)local h for
i,j in ipairs(g)do j.Group=j.Group or'No Group'if h~=j.Group then e:reply(`\n{j.
Group}\n{string.rep('-',#j.Group)}`)h=j.Group end e:reply(if j.Description then`{
j.Name} - {j.Description}`else j.Name)end end return''end}end function a.ck()
local c=a.cache.ck if not c then c={c=b()}a.cache.ck=c end return c.c end end do
local b=function()return{a.J(),a.K(),a.L(),a.M(),a.N(),a.O(),a.P(),a.Q(),a.R(),a
.S(),a.T(),a.U(),a.W(),a.X(),a.Y(),a.Z(),a._(),a.aa(),a.ab(),a.ac(),a.ad(),a.ae(
),a.af(),a.ag(),a.ah(),a.ai(),a.aj(),a.ak(),a.al(),a.am(),a.an(),a.aq(),a.ar(),a
.as(),a.at(),a.au(),a.av(),a.aw(),a.ax(),a.ay(),a.az(),a.aA(),a.aB(),a.aC(),a.
aD(),a.aE(),a.aF(),a.aG(),a.aH(),a.aI(),a.aJ(),a.aK(),a.aL(),a.aM(),a.aN(),a.aO(
),a.aP(),a.aQ(),a.aR(),a.aS(),a.aT(),a.aU(),a.aV(),a.aW(),a.aX(),a.aY(),a.aZ(),a
.a_(),a.a0(),a.a1(),a.a2(),a.a3(),a.a4(),a.a5(),a.a6(),a.a7(),a.a8(),a.a9(),a.
ba(),a.bb(),a.bc(),a.bd(),a.be(),a.bf(),a.bg(),a.bh(),a.bi(),a.bj(),a.bk(),a.bl(
),a.bm(),a.bn(),a.bo(),a.bp(),a.bq(),a.br(),a.bs(),a.bt(),a.bu(),a.bv(),a.bw(),a
.bx(),a.by(),a.bz(),a.bA(),a.bB(),a.bC(),a.bD(),a.bE(),a.bF(),a.bG(),a.bH(),a.
bI(),a.bJ(),a.bK(),a.bL(),a.bM(),a.bN(),a.bO(),a.bP(),a.bQ(),a.bR(),a.bS(),a.bT(
),a.bU(),a.bV(),a.bX(),a.bY(),a.bZ(),a.b_(),a.b0(),a.b1(),a.b3(),a.b4(),a.b5(),a
.b6(),a.b7(),a.b8(),a.b9(),a.ca(),a.cb(),a.cc(),a.cd(),a.ce(),a.cf(),a.cg(),a.
ch(),a.ci(),a.cj(),a.ck()}end function a.cl()local c=a.cache.cl if not c then c=
{c=b()}a.cache.cl=c end return c.c end end do local b=function()local b,c,d=a.a(
),
[[https://github.com/Panda-Utilities/Storage/raw/refs/heads/main/ProggyClean.ttf]]
,{}d.ProggyClean=nil d.Loaded=false local e,f={},function()return type(writefile
)=='function'and type(isfile)=='function'and type(getcustomasset)=='function'end
function d.Get()if d.ProggyClean then return Enum.Font.Code,d.ProggyClean end
return Enum.Font.Code,nil end function d.Apply(g)local h,i=d.Get()g.Font=h if i
then g.FontFace=i end end function d.OnLoaded(g)if d.Loaded then task.spawn(g)
else e[#e+1]=g end end local g=function()if not f()then d.Loaded=true return end
local g,h=pcall(function()return game:HttpGet(c)end)if not g or not h or h==''
then return end if not pcall(writefile,'ProggyClean.ttf',h)then return end local
i=pcall(function()local i={name='ProggyClean',faces={{name='Regular',weight=400,
style='normal',assetId=getcustomasset'ProggyClean.ttf'}}}writefile(
'ProggyClean.ttf.json',b.HttpService:JSONEncode(i))end)if not i then return end
local j,l=pcall(Font.new,getcustomasset'ProggyClean.ttf.json',Enum.FontWeight.
Regular)if j and l then d.ProggyClean=l end end function d.LoadAll()g()d.Loaded=
true for h,i in e do i()end end task.spawn(function()task.wait(1)d.LoadAll()end)
return d end function a.cm()local c=a.cache.cm if not c then c={c=b()}a.cache.cm
=c end return c.c end end do local b=function()local b,c={'box','box fill',
'name','health bar','health text','distance','tool text','highlight'},{}function
c.TeamColor(d,e,f)if d.UseTeamColors and e.teamColor then return e.teamColor end
local g=e.teamState or'neutral'return d.TeamColors[g]and d.TeamColors[g][f]or
Color3.fromRGB(255,255,255)end function c.TeamTransparency(d,e,f)local g=e.
teamState or'neutral'return d.TeamTransparencies[g]and d.TeamTransparencies[g][f
]or 0 end function c.IsFeatureVisible(d,e,f)if not d.Features[f]then return
false end local g=d.ShowOn[f]if not g or#g==0 then return false end local h,i=e.
teamState or'neutral',false for j,l in g do if l==h then i=true break end end if
not i then return false end if f~='highlight'then local j=c.TeamTransparency(d,e
,f)return j<1 end return true end function c.ComputeFeatures(d,e)local f,g={},
false for h,i in b do local j=c.IsFeatureVisible(d,e,i)f[i]=j g=g or j end f.any
=g f.needs2D=f.box or f['box fill']or f.name or f['health bar']or f[
'health text']or f.distance or f['tool text']return f end function c.
HasAnyEnabledFeature(d)for e,f in d.Features do if f then return true end end
return false end return c end function a.cn()local c=a.cache.cn if not c then c=
{c=b()}a.cache.cn=c end return c.c end end do local b=function()local b,c,d={},
function(b,c,d)if not c then return nil,nil,false end local e=d and d:
FindFirstChildOfClass'Humanoid'if not e then return nil,nil,false end local f=e.
RigType==Enum.HumanoidRigType.R6 local g,h=f and 2.8 or 3,f and 3 or 3.5 local i
,j=c.Position+Vector3.new(0,g,0),c.Position-Vector3.new(0,h,0)local l,m=b:
WorldToViewportPoint(i),b:WorldToViewportPoint(j)if l.Z<=0 and m.Z<=0 then
return nil,nil,false end local n,o=math.abs(l.Y-m.Y),b:WorldToViewportPoint(c.
Position)local p,q=Vector2.new(o.X,(l.Y+m.Y)/2),Vector2.new(n*0.65,n)local r,s,t
=p-q/2,p+q/2,Vector2.new(2,2)return r-t,s+t,true end,{Vector3.new(-1,-1,-1),
Vector3.new(-1,-1,1),Vector3.new(-1,1,-1),Vector3.new(-1,1,1),Vector3.new(1,-1,-
1),Vector3.new(1,-1,1),Vector3.new(1,1,-1),Vector3.new(1,1,1)}function b.Get(e,f
,g,h,i)if e.DynamicBoxes and g and#g>0 then local j,l,m=Vector2.new(math.huge,
math.huge),Vector2.new(-math.huge,-math.huge),false for n,o in g do if o.Parent
and o.Parent:IsA'Tool'then continue end if h and(o.Position-h.Position).
Magnitude>15 then continue end local p,q=o.CFrame,o.Size*0.5 for r,s in d do
local t=p*(q*s)local u=f:WorldToViewportPoint(t)if u.Z>0 then m=true if u.X<j.X
then j=Vector2.new(u.X,j.Y)end if u.Y<j.Y then j=Vector2.new(j.X,u.Y)end if u.X>
l.X then l=Vector2.new(u.X,l.Y)end if u.Y>l.Y then l=Vector2.new(l.X,u.Y)end end
end end if not m then return nil,nil,false end local n=Vector2.new(2,2)return j-
n,l+n,true end return c(f,h,i)end return b end function a.co()local c=a.cache.co
if not c then c={c=b()}a.cache.co=c end return c.c end end do local b=function()
local b,c,d={'Head','Torso','Left Arm','Right Arm','Left Leg','Right Leg'},{
'Head','UpperTorso','LowerTorso','LeftHand','RightHand','LeftFoot','RightFoot',
'LeftLowerArm','RightLowerArm','LeftLowerLeg','RightLowerLeg','LeftUpperArm',
'RightUpperArm','LeftUpperLeg','RightUpperLeg'},function(b)return b and b.
Character end local e=function(e)if not e then return nil end local f=e:
FindFirstChildOfClass'Humanoid'if not f then return nil end local g,h={},f.
RigType==Enum.HumanoidRigType.R6 and b or c for i,j in h do local l=e:
FindFirstChild(j)if l and l:IsA'BasePart'then g[#g+1]=l end end return#g>0 and g
or nil end return{GetCharacter=d,GetBodyParts=e}end function a.cp()local c=a.
cache.cp if not c then c={c=b()}a.cache.cp=c end return c.c end end do local b=
function()local b,c,d,e=a.k(),a.g(),{},{}function e.ensure(f,g)if d[f]then
return end local h,i,j=b('Frame',{Parent=f.root,BackgroundColor3=Color3.fromRGB(
255,255,255),BackgroundTransparency=0.85,BorderSizePixel=0,Visible=false}),b(
'Frame',{Parent=f.root,BackgroundTransparency=1,BorderSizePixel=0,Visible=false}
),b('Frame',{Parent=f.root,BackgroundTransparency=1,BorderSizePixel=0,Visible=
false})local l,m=b('UIStroke',{Parent=j,Color=c.Colors.Stroke,Thickness=1,
LineJoinMode=Enum.LineJoinMode.Miter}),b('Frame',{Parent=f.root,
BackgroundTransparency=1,BorderSizePixel=0,Visible=false})local n,o=b('UIStroke'
,{Parent=m,Color=c.Colors.Stroke,Thickness=1,LineJoinMode=Enum.LineJoinMode.
Miter}),b('UIStroke',{Parent=i,Color=Color3.fromRGB(255,255,255),Thickness=1,
Transparency=0,LineJoinMode=Enum.LineJoinMode.Miter})f.box=i f.boxStroke=o f.
boxOuterOutline=j f.boxOuterStroke=l f.boxInnerOutline=m f.boxInnerStroke=n f.
boxFill=h d[f]={box=i,boxStroke=o,boxOuterOutline=j,boxOuterStroke=l,
boxInnerOutline=m,boxInnerStroke=n,boxFill=h}end function e.update(f,g,h)local i
=d[f]if not i then return end if not h then i.box.Visible=false i.boxFill.
Visible=false i.boxOuterOutline.Visible=false i.boxInnerOutline.Visible=false
return end local j=f.features local l,m=j.box,j['box fill']if not l and not m
then i.box.Visible=false i.boxFill.Visible=false i.boxOuterOutline.Visible=false
i.boxInnerOutline.Visible=false return end local n,o=h.size,UDim2.fromOffset(0,0
)local p,q,r,s,t=UDim2.fromOffset(n.X,n.Y),UDim2.fromOffset(-1,-1),UDim2.
fromOffset(n.X+2,n.Y+2),UDim2.fromOffset(1,1),UDim2.fromOffset(math.max(n.X-2,0)
,math.max(n.Y-2,0))if i.lastPosition~=o then i.lastPosition=o i.box.Position=o
end if i.lastSize~=p then i.lastSize=p i.box.Size=p end if i.lastOuterPosition~=
q then i.lastOuterPosition=q i.boxOuterOutline.Position=q end if i.lastOuterSize
~=r then i.lastOuterSize=r i.boxOuterOutline.Size=r end if i.lastInnerPosition~=
s then i.lastInnerPosition=s i.boxInnerOutline.Position=s end if i.lastInnerSize
~=t then i.lastInnerSize=t i.boxInnerOutline.Size=t end if i.lastFillPosition~=o
then i.lastFillPosition=o i.boxFill.Position=o end if i.lastFillSize~=p then i.
lastFillSize=p i.boxFill.Size=p end local u,v=h.boxFillColor,h.
boxFillTransparency if i.lastFillColor~=u then i.lastFillColor=u i.boxFill.
BackgroundColor3=u end if i.lastFillTransparency~=v then i.lastFillTransparency=
v i.boxFill.BackgroundTransparency=v end local w,x=h.boxColor,h.boxTransparency
if i.lastStrokeColor~=w then i.lastStrokeColor=w i.boxStroke.Color=w end if i.
lastStrokeTransparency~=x then i.lastStrokeTransparency=x i.boxStroke.
Transparency=x i.boxOuterStroke.Color=c.Colors.Stroke i.boxOuterStroke.
Transparency=x i.boxInnerStroke.Color=c.Colors.Stroke i.boxInnerStroke.
Transparency=x end i.box.Visible=l i.boxOuterOutline.Visible=l i.boxInnerOutline
.Visible=l i.boxFill.Visible=m end function e.destroy(f)local g=d[f]if g then g.
box:Destroy()g.boxFill:Destroy()g.boxOuterOutline:Destroy()g.boxInnerOutline:
Destroy()d[f]=nil end f.box=nil f.boxFill=nil f.boxOuterOutline=nil f.
boxInnerOutline=nil f.boxStroke=nil f.boxOuterStroke=nil f.boxInnerStroke=nil
end return e end function a.cq()local c=a.cache.cq if not c then c={c=b()}a.
cache.cq=c end return c.c end end do local b=function()local b,c,d,e=a.k(),a.g()
,{},{}function e.ensure(f,g)if d[f]then return end local h=b('Frame',{Parent=f.
root,BackgroundColor3=c.Colors.Stroke,BorderSizePixel=0,Visible=false})local i,j
=b('UIStroke',{Parent=h,Color=c.Colors.Stroke,Enabled=false,Thickness=1,
LineJoinMode=Enum.LineJoinMode.Miter}),b('Frame',{Parent=h,BackgroundColor3=
Color3.fromRGB(255,255,255),BorderSizePixel=0})local l=b('UIGradient',{Rotation=
-90,Parent=j})f.healthOutline=h f.healthOutlineStroke=i f.healthBar=j f.
healthGradient=l d[f]={healthOutline=h,healthOutlineStroke=i,healthBar=j,
healthGradient=l}end function e.update(f,g,h)local i=d[f]if not i then return
end if not h then i.healthOutline.Visible=false return end if not f.features[
'health bar']then i.healthOutline.Visible=false return end local j,l,m,n,o,p,q=h
.size,h.healthTransparency,h.healthBarGap,h.healthBarWidth,h.healthBarOutline,h.
healthBarYOffset,h.displayHealthRatio local r,s=n+o*2,math.max(j.Y-p*2,0)local t
,u=UDim2.fromOffset(-(m+r),p),UDim2.fromOffset(r,s)if i.lastOutlinePosition~=t
then i.lastOutlinePosition=t i.healthOutline.Position=t end if i.lastOutlineSize
~=u then i.lastOutlineSize=u i.healthOutline.Size=u end if i.
lastOutlineTransparency~=l then i.lastOutlineTransparency=l i.healthOutline.
BackgroundTransparency=l end local v=math.max(s-o*2,0)local w,x=UDim2.
fromOffset(o,v*(1-q)+o),UDim2.fromOffset(n,math.max(v*q,0))if i.lastBarPosition
~=w then i.lastBarPosition=w i.healthBar.Position=w end if i.lastBarSize~=x then
i.lastBarSize=x i.healthBar.Size=x end if i.lastBarTransparency~=l then i.
lastBarTransparency=l i.healthBar.BackgroundTransparency=l end local y=h.
healthColor local z=if h.healthBarGradientDirection=='brighter'then y:Lerp(
Color3.new(1,1,1),0.8)else y:Lerp(Color3.new(),0.8)local A=ColorSequence.new{
ColorSequenceKeypoint.new(0,z),ColorSequenceKeypoint.new(1,y)}if i.
lastGradientColor~=A then i.lastGradientColor=A i.healthGradient.Color=A end i.
healthOutline.Visible=true end function e.destroy(f)local g=d[f]if g then g.
healthOutline:Destroy()g.healthBar:Destroy()d[f]=nil end f.healthOutline=nil f.
healthBar=nil f.healthOutlineStroke=nil f.healthGradient=nil end return e end
function a.cr()local c=a.cache.cr if not c then c={c=b()}a.cache.cr=c end return
c.c end end do local b=function()local b,c=a.k(),{}function c.ensure(d,e)if d.
highlight then return end local f=(pcall(gethui)and gethui())or game:GetService
'CoreGui'd.highlight=(b('Highlight',{Parent=f}))end function c.update(d,e,f)if
not f then if d.highlight then d.highlight.Enabled=false end return end local g=
d.features if not g.highlight then if d.highlight then d.highlight.Enabled=false
end return end if not d.highlight then return end local h=f.character if not h
then d.highlight.Enabled=false return end d.highlight.Adornee=h d.highlight.
DepthMode=f.highlightBehindWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum
.HighlightDepthMode.Occluded d.highlight.FillColor=f.highlightFillColor d.
highlight.FillTransparency=f.highlightFillTransparency d.highlight.OutlineColor=
f.highlightOutlineColor d.highlight.OutlineTransparency=f.
highlightOutlineTransparency d.highlight.Enabled=true end function c.destroy(d)
if d.highlight then d.highlight:Destroy()d.highlight=nil end end return c end
function a.cs()local c=a.cache.cs if not c then c={c=b()}a.cache.cs=c end return
c.c end end do local b=function()local b,c,d=a.k(),a.cm(),a.g()local e=function(
e)local f,g={},{}function g.ensure(h,i)if f[h]then return end local j=b(
'TextLabel',{Parent=i,AnchorPoint=e.anchorPoint or Vector2.new(0.5,0),
BackgroundTransparency=1,BorderSizePixel=0,Font=Enum.Font.Code,Size=e.labelSize
or UDim2.fromOffset(160,14),TextSize=e.textSize or 12,TextTransparency=0,
TextStrokeTransparency=1,Visible=false})c.Apply(j)local l=b('UIStroke',{Parent=j
,Color=d.Colors.Stroke,Transparency=0,Thickness=1,LineJoinMode=Enum.LineJoinMode
.Miter})h[e.storageKey]=j h[e.strokeKey]=l f[h]={label=j,stroke=l}end function g
.update(h,i,j)local l=f[h]if not l then return end if not j then l.label.Visible
=false return end if not h.features[e.featureKey]then l.label.Visible=false
return end local m=e.positionFn(j.min,j.size,j)if l.lastPosition~=m then l.
lastPosition=m l.label.Position=m end c.Apply(l.label)local n=e.textFn(j)if l.
lastText~=n then l.lastText=n l.label.Text=n end local o=j[e.colorKey]if l.
lastColor~=o then l.lastColor=o l.label.TextColor3=o end local p=j[e.
transparencyKey]if l.lastTransparency~=p then l.lastTransparency=p l.label.
TextTransparency=p l.stroke.Transparency=p end if e.visibleFn then l.label.
Visible=e.visibleFn(n,j)else l.label.Visible=true end end function g.destroy(h)
local i=f[h]if i then i.label:Destroy()f[h]=nil end h[e.storageKey]=nil h[e.
strokeKey]=nil end return g end return e end function a.ct()local c=a.cache.ct
if not c then c={c=b()}a.cache.ct=c end return c.c end end do local aa=function(
)local b,c,d,e,f,g,h,i,j,l,m=a.k(),a.a(),a.ap(),a.cm(),a.cn(),a.co(),a.cp(),a.
cq(),a.cr(),a.cs(),a.ct()local n,o,p,q,r=c.Players,c.RunService,c.
UserInputService,d.create(),(pcall(gethui)and gethui())or c.CoreGui local s,t,u,
v,w=b('ScreenGui',{Name='CoCo_ESP',DisplayOrder=999999,IgnoreGuiInset=true,
ResetOnSpawn=false,Parent=r}),m{storageKey='name',strokeKey='nameStroke',
featureKey='name',positionFn=function(s,t)return UDim2.fromOffset(s.X+t.X/2,s.Y-
17)end,textFn=function(s)return s.nameText end,colorKey='nameColor',
transparencyKey='nameTransparency'},m{storageKey='distanceText',strokeKey=
'distanceTextStroke',featureKey='distance',positionFn=function(s,t)return UDim2.
fromOffset(s.X+t.X/2,s.Y+t.Y+1)end,textFn=function(s)return tostring(s.distance)
..'M'end,colorKey='distanceColor',transparencyKey='distanceTransparency'},m{
storageKey='healthText',strokeKey='healthTextStroke',featureKey='health text',
positionFn=function(s,t,u)return UDim2.fromOffset(s.X-23,s.Y+t.Y*(1-u.
displayHealthRatio)-3)end,textFn=function(s)if s.hideFullHealth and s.
healthRatio>=1 then return''end return tostring(math.floor(s.healthValue+0.5))..
'%'end,colorKey='healthTextColor',transparencyKey='healthTextTransparency'},m{
storageKey='toolText',strokeKey='toolTextStroke',featureKey='tool text',
positionFn=function(s,t,u)return UDim2.fromOffset(s.X+t.X/2,s.Y+t.Y+(u.
distanceEnabled and 15 or 1))end,textFn=function(s)return s.toolText end,
colorKey='toolTextColor',transparencyKey='toolTextTransparency',visibleFn=
function(s)return s~=''end}local x,y,z,A,B,C,D,E,F={{keys={'box','box fill'},mod
=i},{keys={'health bar'},mod=j},{keys={'health text'},mod=v},{keys={'name'},mod=
t},{keys={'distance'},mod=u},{keys={'tool text'},mod=w},{keys={'highlight'},mod=
l}},{},false,0,c.Workspace.CurrentCamera,n.LocalPlayer,function(x)if q.
TextCasing=='uppercase'then return string.upper(x)elseif q.TextCasing==
'lowercase'then return string.lower(x)end return x end,function(x)if not x then
return''end local y=x:FindFirstChildOfClass'Tool'if not y then return''end local
z=y.Name:gsub('^%[',''):gsub('%]$',''):gsub('[^%w%s_%-]','')z=z:gsub(
'([a-z%d])([A-Z])','%1 %2'):gsub('([A-Z]+)([A-Z][a-z])','%1 %2')return q.
ToolTextCasing=='uppercase'and string.upper(z)or string.lower(z)end local G,H=
function(G)for H,I in x do I.mod.update(G,nil,nil)end end,function(G,H)for I,J
in ipairs(G.characterConns)do J:Disconnect()end G.characterConns={}G.character=H
G.humanoid=H:FindFirstChildOfClass'Humanoid'G.rootPart=(H:FindFirstChild
'HumanoidRootPart')G.bodyParts=h.GetBodyParts(H)local I=function()local I=H:
FindFirstChildOfClass'Tool'if I~=G.tool then G.tool=I end end table.insert(G.
characterConns,H.ChildAdded:Connect(function(J)if J:IsA'Tool'then I()end end))
table.insert(G.characterConns,H.ChildRemoved:Connect(function(J)if J:IsA'Tool'
then I()end end))table.insert(G.characterConns,H.DescendantAdded:Connect(
function(J)if J:IsA'BasePart'and J.Name=='HumanoidRootPart'then if not G.
rootPart then G.rootPart=J end end if J:IsA'Humanoid'then if not G.humanoid then
G.humanoid=J G.health=J.Health G.maxHealth=J.MaxHealth table.insert(G.
characterConns,J:GetPropertyChangedSignal'Health':Connect(function()G.health=J.
Health G.maxHealth=J.MaxHealth end))table.insert(G.characterConns,J:
GetPropertyChangedSignal'RigType':Connect(function()G.bodyParts=h.GetBodyParts(H
)end))end end if J:IsA'Tool'then if J~=G.tool then G.tool=J end end G.bodyParts=
h.GetBodyParts(H)end))table.insert(G.characterConns,H.DescendantRemoving:
Connect(function()G.bodyParts=h.GetBodyParts(H)end))I()if G.humanoid then G.
health=G.humanoid.Health G.maxHealth=G.humanoid.MaxHealth table.insert(G.
characterConns,G.humanoid:GetPropertyChangedSignal'Health':Connect(function()G.
health=G.humanoid.Health G.maxHealth=G.humanoid.MaxHealth end))table.insert(G.
characterConns,G.humanoid:GetPropertyChangedSignal'RigType':Connect(function()G.
bodyParts=h.GetBodyParts(H)end))end end local I,J=function(I)for J,K in ipairs(I
.characterConns)do K:Disconnect()end I.characterConns={}I.character=nil I.
humanoid=nil I.rootPart=nil I.bodyParts=nil I.tool=nil G(I)end,function(I)for J,
K in x do K.mod.destroy(I)end for J,K in ipairs(I.connections)do K:Disconnect()
end for J,K in ipairs(I.characterConns)do K:Disconnect()end I.root:Destroy()y[I.
player]=nil end local aa,ab=function(K)local L=K.features if K.leaving then K.
fadeTransparency=math.min(K.fadeTransparency+0.12,1)if K.fadeTransparency>=1 or
not K.lastState then J(K)return end local M,N=K.fadeTransparency,K.lastState
local O={min=N.min,size=N.size,healthRatio=N.healthRatio,healthValue=0,
displayHealthRatio=N.displayHealthRatio,distance=N.distance,nameText=D(N.
nameText),toolText=N.toolText,distanceEnabled=N.distanceEnabled,boxColor=f.
TeamColor(q,K,'box'),boxTransparency=1-(1-f.TeamTransparency(q,K,'box'))*(1-M),
boxFillColor=f.TeamColor(q,K,'box fill'),boxFillTransparency=1-(1-f.
TeamTransparency(q,K,'box fill'))*(1-M),nameColor=f.TeamColor(q,K,'name'),
nameTransparency=1-(1-f.TeamTransparency(q,K,'name'))*(1-M),healthColor=f.
TeamColor(q,K,'health bar'),healthTransparency=1-(1-f.TeamTransparency(q,K,
'health bar'))*(1-M),healthTextColor=f.TeamColor(q,K,'health text'),
healthTextTransparency=1-(1-f.TeamTransparency(q,K,'health text'))*(1-M),
distanceColor=f.TeamColor(q,K,'distance'),distanceTransparency=1-(1-f.
TeamTransparency(q,K,'distance'))*(1-M),toolTextColor=f.TeamColor(q,K,
'tool text'),toolTextTransparency=1-(1-f.TeamTransparency(q,K,'tool text'))*(1-M
),highlightFillColor=f.TeamColor(q,K,'highlight'),highlightFillTransparency=1-(1
-f.TeamTransparency(q,K,'highlight'))*(1-M),highlightOutlineColor=q.
HighlightOutlineColor,highlightOutlineTransparency=1-(1-q.
HighlightOutlineTransparency)*(1-M),highlightBehindWalls=q.HighlightBehindWalls,
hideFullHealth=q.HideFullHealthText,healthBarGap=q.HealthBarGap,healthBarWidth=q
.HealthBarWidth,healthBarOutline=q.HealthBarOutline,healthBarYOffset=q.
HealthBarYOffset,healthBarGradientDirection=q.HealthBarGradientDirection,visible
=true,character=nil}K.root.Position=UDim2.fromOffset(O.min.X,O.min.Y)K.root.Size
=UDim2.fromOffset(O.size.X,O.size.Y)for P,Q in x do Q.mod.ensure(K,s)Q.mod.
update(K,K,O)end return end local M,N,O=K.character,K.humanoid,K.rootPart if not
B or not M or not N or not O or N.Health<=0 then G(K)return end if not L.needs2D
then G(K)if L.highlight then l.update(K,K,{visible=true,character=M,
highlightBehindWalls=q.HighlightBehindWalls,highlightFillColor=f.TeamColor(q,K,
'highlight'),highlightFillTransparency=f.TeamTransparency(q,K,'highlight'),
highlightOutlineColor=q.HighlightOutlineColor,highlightOutlineTransparency=q.
HighlightOutlineTransparency})end return end local P,Q,R=K.player,false,K.
teamState if P==C and not q.ShowLocal then G(K)return end if Q and not q.
ShowTarget then G(K)return end if R=='friendly'and not q.ShowFriendlies then G(K
)return end if R=='enemy'and not q.ShowEnemies then G(K)return end if R==
'neutral'and not q.ShowNeutral then G(K)return end if q.TeamCheck and(R==
'friendly'or R=='neutral')then G(K)return end local S=h.GetCharacter(C)local T=S
and S:FindFirstChild'HumanoidRootPart'if T and(O.Position-(T).Position).
Magnitude>q.MaxDistance then G(K)return end local U=B:WorldToViewportPoint(O.
Position)if U.Z<=0 then G(K)return end local V,W=B.ViewportSize,500 if U.X<-W or
U.X>V.X+W or U.Y<-W or U.Y>V.Y+W then G(K)return end local X if q.DynamicBoxes
then if q.DynamicBoxesIncludeAll and M then X={}for Y,Z in M:GetChildren()do if
Z:IsA'BasePart'then X[#X+1]=Z end end else X=K.bodyParts or{}end end local Y,Z,_
=g.Get(q,B,X,O,M)if not _ or not Y or not Z then G(K)return end local aa,ab,ac,
ad=Y,Z-Y,K.health,math.max(K.maxHealth,1)local ae=math.clamp(ac/ad,0,1)K.
displayedHealthRatio+=(ae-K.displayedHealthRatio)*0.18 if math.abs(K.
displayedHealthRatio-ae)<0.005 then K.displayedHealthRatio=ae end local af,ag,ah
,ai=K.displayedHealthRatio,T and math.floor((O.Position-(T).Position).Magnitude+
0.5)or 0,if P then(q.UseDisplayName and P.DisplayName or P.Name)else M and M.
Name or'unknown',E(M)K.root.Position=UDim2.fromOffset(aa.X,aa.Y)K.root.Size=
UDim2.fromOffset(ab.X,ab.Y)if not K.leaving and K.fadeTransparency>0 then K.
fadeTransparency=math.max(K.fadeTransparency-0.08,0)end local aj,ak=K.
fadeTransparency,f.TeamColor(q,K,'box')local al,am,an,ao,ap,aq,ar,as,at,au,av,aw
,ax,ay,az=1-(1-f.TeamTransparency(q,K,'box'))*(1-aj),f.TeamColor(q,K,'box fill')
,1-(1-f.TeamTransparency(q,K,'box fill'))*(1-aj),f.TeamColor(q,K,'name'),1-(1-f.
TeamTransparency(q,K,'name'))*(1-aj),f.TeamColor(q,K,'health bar'),1-(1-f.
TeamTransparency(q,K,'health bar'))*(1-aj),f.TeamColor(q,K,'health text'),1-(1-f
.TeamTransparency(q,K,'health text'))*(1-aj),f.TeamColor(q,K,'distance'),1-(1-f.
TeamTransparency(q,K,'distance'))*(1-aj),f.TeamColor(q,K,'tool text'),1-(1-f.
TeamTransparency(q,K,'tool text'))*(1-aj),f.TeamColor(q,K,'highlight'),1-(1-f.
TeamTransparency(q,K,'highlight'))*(1-aj)local aA={min=aa,size=ab,healthRatio=ae
,healthValue=ac,displayHealthRatio=af,distance=ag,nameText=D(ah),toolText=ai,
distanceEnabled=L.distance,boxColor=ak,boxTransparency=al,boxFillColor=am,
boxFillTransparency=an,nameColor=ao,nameTransparency=ap,healthColor=aq,
healthTransparency=ar,healthTextColor=as,healthTextTransparency=at,
hideFullHealth=q.HideFullHealthText,distanceColor=au,distanceTransparency=av,
toolTextColor=aw,toolTextTransparency=ax,highlightFillColor=ay,
highlightFillTransparency=az,highlightOutlineColor=q.HighlightOutlineColor,
highlightOutlineTransparency=q.HighlightOutlineTransparency,highlightBehindWalls
=q.HighlightBehindWalls,healthBarGap=q.HealthBarGap,healthBarWidth=q.
HealthBarWidth,healthBarOutline=q.HealthBarOutline,healthBarYOffset=q.
HealthBarYOffset,healthBarGradientDirection=q.HealthBarGradientDirection,visible
=true,character=M}for aB,aC in x do local aD=false for aE,aF in aC.keys do if L[
aF]then aD=true break end end if aD then aC.mod.ensure(K,s)aC.mod.update(K,K,aA)
else aC.mod.update(K,K,nil)end end K.lastState={min=aa,size=ab,nameText=ah,
toolText=ai,healthRatio=ae,displayHealthRatio=af,distance=ag,distanceEnabled=L.
distance}end,function()if F then F:Disconnect()F=nil end for aa,ab in pairs(y)do
G(ab)end end local ac,ad=function()if not q.Enabled or not f.
HasAnyEnabledFeature(q)then ab()return end if q.LimitFPS>0 then local ac=tick()
if ac-A<(1/q.LimitFPS)then return end A=ac end B=c.Workspace.CurrentCamera h.
GetCharacter(C)for ac,ad in pairs(y)do if ad and ad.features and ad.features.any
then aa(ad)elseif ad then G(ad)end end end local ae=function()if F then return
end if not q.Enabled or not f.HasAnyEnabledFeature(q)then return end F=o.
RenderStepped:Connect(ac)for ae,af in n:GetPlayers()do if not y[af]then ad(af)
end end end ad=function(af)if y[af]then return end local ag=b('Frame',{Parent=s,
BackgroundTransparency=1,BorderSizePixel=0,Size=UDim2.fromOffset(0,0),Visible=
true})local ah={player=af,root=ag,features={},displayedHealthRatio=1,connections
={},characterConns={},character=nil,humanoid=nil,rootPart=nil,health=100,
maxHealth=100,teamState='neutral',teamColor=nil,tool=nil,bodyParts=nil,
fadeTransparency=1,leaving=false,lastState=nil}local ai=function()if af==n.
LocalPlayer then ah.teamState='local'elseif af.Team and af.Team~=n.LocalPlayer.
Team then ah.teamState='enemy'elseif af.Team and af.Team==n.LocalPlayer.Team
then ah.teamState='friendly'else ah.teamState='neutral'end ah.teamColor=af.Team
and af.Team.TeamColor.Color or nil ah.features=f.ComputeFeatures(q,ah)end ai()
table.insert(ah.connections,af:GetPropertyChangedSignal'Team':Connect(ai))table.
insert(ah.connections,af.CharacterAdded:Connect(function(aj)I(ah)H(ah,aj)ae()end
))table.insert(ah.connections,af.CharacterRemoving:Connect(function()I(ah)end))
if af.Character then H(ah,af.Character)if q.Enabled then ae()end end ah.features
=f.ComputeFeatures(q,ah)y[af]=ah if ah.features.any then ae()end end local af=
function()if not q.Enabled or not f.HasAnyEnabledFeature(q)then for af,ag in
pairs(y)do J(ag)end return false end for af,ag in n:GetPlayers()do if not y[ag]
then ad(ag)end end local af=false for ag,ah in pairs(y)do local ai=f.
ComputeFeatures(q,ah)ah.features=ai if ai.any then af=true end end return af end
local ag=function()if z then return end z=true task.defer(function()z=false if
af()then ae()else ab()end end)end n.PlayerAdded:Connect(ad)for ah,ai in n:
GetPlayers()do ad(ai)end n.PlayerRemoving:Connect(function(ah)local ai=y[ah]if
ai then if ai.lastState then ai.leaving=true else J(ai)end end end)q.Changed:
Connect(function()ag()end)e.OnLoaded(function()ag()end)local ah={}setmetatable(
ah,{__index=function(ai,aj)return q[aj]end,__newindex=function(ai,aj,ak)q[aj]=ak
q.Changed:Fire()end})return{esp=q,playerData=y,bindings=ah,queueReconcile=ag,
start=ae,stop=ab}end function a.cu()local ab=a.cache.cu if not ab then ab={c=aa(
)}a.cache.cu=ab end return ab.c end end do local aa=function()local aa=a.l()
return function(ab)aa()local ac={a.m(),a.p(),a.q(),a.r(),a.s(),a.t(),a.u(),a.v()
,a.w(),a.x(),a.y(),a.z(),a.A(),a.B(),a.C(),a.D(),a.E(),a.F(),a.G(),a.I()}for ad,
ae in ipairs(ac)do ae(ab)end local ad=a.cl()for ae,af in ipairs(ad)do ab.
Registry:registerCommandObject(af)end local ae=a.cu()ab.ESP=ae.esp end end
function a.cv()local ab=a.cache.cv if not ab then ab={c=aa()}a.cache.cv=ab end
return ab.c end end do local aa=function()local aa do aa=setmetatable({},{
__index=function(ab,ac)local ad=ab.Registry[ac]if ad and type(ad)=='function'
then return function(ae,...)return ad(ab.Registry,...)end end end})local ab=a.a(
)local ac=ab.Players aa.Registry=a.e()(aa)aa.Dispatcher=a.j()(aa,ac.LocalPlayer)
a.cv()(aa)end return aa end function a.cw()local ab=a.cache.cw if not ab then ab
={c=aa()}a.cache.cw=ab end return ab.c end end do local aa=function()local aa,ab
,ac=function(aa,...)if type(aa)=='thread'then coroutine.resume(aa,...)return aa
else local ab=coroutine.create(aa)coroutine.resume(ab,...)return ab end end,
function(aa)local ab,ac=coroutine.close(aa)if not ab then error(`[TASK] could not cancel thread\n\terror: {
ac}`)end end,function(aa)local ab=os.clock()local ac,ad=(ab+(aa or 1))repeat ad=
os.clock()until ad>=ac return ad-ab end local ad=function(ad,ae,...)local af=aa(
function(af,ag,...)ac(af)if type(ag)=='thread'then coroutine.resume(ag,...)else
ag(...)end end,ad,ae,...)return af end return table.freeze{cancel=ab,spawn=aa,
defer=aa,delay=ad,wait=ac}end function a.cx()local ab=a.cache.cx if not ab then
ab={c=aa()}a.cache.cx=ab end return ab.c end end do local aa=function()local aa=
function(...)print(`\27[0;33m{table.concat({...},' ')}\27[0m`)end return aa end
function a.cy()local ab=a.cache.cy if not ab then ab={c=aa()}a.cache.cy=ab end
return ab.c end end do local aa=function()local aa,ab,ac=a.cx(),a.cy(),if game
and game.ClassName=='DataModel'and game.GraphicsQualityChangeRequest then
'ROBLOX'elseif string.find(_VERSION,'Lune')then'LUNE'else'NONE'local ad,ae=warn
or ab,if task then task elseif ac=='LUNE'then(require)'@lune/task'else aa do
local af=function(af,ag)if not _G[af]then _G[af]=ag end end if not _RUNTIME then
af('_RUNTIME',ac)_RUNTIME=ac end if not warn then af('warn',ad)warn=ad end if
not task then af('task',ae)task=ae end end return table.freeze{cancel=ae.cancel,
spawn=ae.spawn,defer=ae.defer,delay=ae.delay,wait=ae.wait,warn=ad,runtime=ac}end
function a.cz()local ab=a.cache.cz if not ab then ab={c=aa()}a.cache.cz=ab end
return ab.c end end do local aa=function()local aa,ab,ac,ad,ae=a.cz(),
[[Object is a %* and as such expected `true?` for the method name and instead got %*. Traceback: %*]]
,
[[Object %* doesn't have method %*, are you sure you want to add it? Traceback: %*]]
,
[[Invalid argument #1 to 'Janitor:AddPromise' (Promise expected, got %* (%*)) Traceback: %*]]
,{}local af=ae ae.ClassName='Janitor'ae.CurrentlyCleaning=true ae.
UnsafeThreadCleanup=false(ae).__index=ae local ag,ah=setmetatable({},{__mode=
'ks'}),{['function']=true,thread=true}function ae.new()return(setmetatable({
CurrentlyCleaning=false},ae))end function ae.Is(ai)return type(ai)=='table'and
getmetatable(ai)==ae end ae.instanceof=ae.Is local ai=function(ai,aj)local ak=ag
[ai]if ak then local al=ak[aj]if not al then return ai end local am=ai[al]if am
then if am==true then if type(al)=='function'then al()else local an if coroutine
.running()~=al then an=pcall(function()aa.cancel(al)end)end if not an then local
ao=al if ai.UnsafeThreadCleanup then aa.spawn(function()aa.cancel(ao)end)else aa
.defer(function()aa.cancel(ao)end)end end end else local an,ao=pcall(function()
return((al)[am])end)if an and ao then ao(al)end end ai[al]=nil end ak[aj]=nil
end return ai end local aj=function(aj,ak,al,am)if am then ai(aj,am)local an=ag[
aj]if not an then an={}ag[aj]=an end an[am]=ak end local an=typeof(ak)local ao=
al or ah[an]or'Destroy'if an=='function'or an=='thread'then if ao~=true then aa.
warn(string.format(ab,an,tostring(ao),debug.traceback(nil,2)))end else local ap=
pcall(function()return(ak)[ao]end)if not ap then aa.warn(string.format(ac,
tostring(ak),tostring(ao),debug.traceback(nil,2)))end end aj[ak]=ao return ak
end af.Add=aj function ae:AddObject(ak,al,am,...)return aj(self,ak.new(...),al,
am)end local ak=function(ak,al)local am=ag[ak]return if am then am[al]else nil
end ae.Get=ak function ae:AddPromise(al,am)if not Promise then return al end if
not Promise.is(al)then error(string.format(ad,typeof(al),tostring(al),debug.
traceback(nil,2)))end if al:getStatus()~=Promise.Status.Started then return al
end local an=am if an==nil then an=newproxy(false)end local ao=aj(self,Promise.
new(function(ao,ap,aq)if aq(function()al:cancel()end)then return end ao(al)end),
'cancel',an)ao:finally(function()if ak(self,an)==ao then ai(self,an)end end)
return ao end af.Remove=ai function af:RemoveNoClean(al)local am=ag[self]if am
then local an=am[al]if an then self[an]=nil am[al]=nil end end return self end
function ae:RemoveList(...)local al=ag[self]if al then local am=select('#',...)
if am==1 then return ai(self,...)end if am==2 then local an,ao=...ai(self,an)ai(
self,ao)return self end if am==3 then local an,ao,ap=...ai(self,an)ai(self,ao)
ai(self,ap)return self end for an=1,am do local ao=select(an,...)ai(self,ao)end
end return self end function ae:RemoveListNoClean(...)local al=ag[self]if al
then local am=select('#',...)if am==1 then local an=...local ao=al[an]if ao then
self[ao]=nil al[an]=nil end return self end if am==2 then local an,ao=...local
ap=al[an]if ap then self[ap]=nil al[an]=nil end local aq=al[ao]if aq then self[
aq]=nil al[ao]=nil end return self end if am==3 then local an,ao,ap=...local aq=
al[an]if aq then self[aq]=nil al[an]=nil end local ar=al[ao]if ar then self[ar]=
nil al[ao]=nil end local as=al[ap]if as then self[as]=nil al[ap]=nil end return
self end for an=1,am do local ao=select(an,...)local ap=al[ao]if ap then self[ap
]=nil al[ao]=nil end end end return self end function ae:GetAll()local al=ag[
self]return if al then table.freeze(table.clone(al))else{}end local al=function(
al)if not al.CurrentlyCleaning then local am=al.UnsafeThreadCleanup al.
CurrentlyCleaning=nil al.UnsafeThreadCleanup=nil local an,ao=next(al)while an
and ao do if ao==true then if type(an)=='function'then an()else local ap if
coroutine.running()~=an then ap=pcall(function()aa.cancel(an)end)end if not ap
then local aq=an if am then aa.spawn(function()aa.cancel(aq)end)else aa.defer(
function()aa.cancel(aq)end)end end end else local ap,aq=pcall(function()return((
an)[ao])end)if ap and aq then aq(an)end end al[an]=nil an,ao=next(al,an)end
local ap=ag[al]if ap then table.clear(ap)ag[al]=nil end al.CurrentlyCleaning=
false al.UnsafeThreadCleanup=am end end af.Cleanup=al function ae:Destroy()al(
self)table.clear(self)setmetatable(self,nil)end af.__call=al function af:
__tostring()return'Janitor'end return ae end function a.cA()local ab=a.cache.cA
if not ab then ab={c=aa()}a.cache.cA=ab end return ab.c end end do local aa=
function()local aa=function(aa,ab)local ac=aa for ad,ae in ab do if aa[ad]==ae
then continue end if ac==aa then ac=table.clone(aa)end ac[ad]=ae end return ac
end return aa end function a.cB()local ab=a.cache.cB if not ab then ab={c=aa()}a
.cache.cB=ab end return ab.c end end do local aa=function()local aa,ab,ac=a.cB()
,{number=function(aa,ab)aa[1]=ab end,vector=function(aa,ab)aa[1]=ab end,table=
function(aa,ab)for ac,ad in ab do aa[ac]=ad end end},{number=function(aa)return
aa[1]end,vector=function(aa)return aa[1]end,table=function(aa)return table.
clone(aa)end}local ad,ae,af,ag=function(ad)local ae,af=typeof(ad),{}local ag,ah=
ab[ae],ac[ae]if not ag or not ah then error(`Unsupported type {ae} for Ripple animation value`
)end ag(af,ad)return{components=af,value=ad,encode=ag,decode=ah}end,function(ad)
return{components=table.clone(ad.components),value=ad.value,encode=ad.encode,
decode=ad.decode}end,function(ad)local ae=ad.components for af in ae do ae[af]*=
0 end ad.dirty=true return ad end,function(ad)local ae=ad.decode(ad.components)
ad.value=ae ad.dirty=nil return ae end local ah=function(ah)return if ah.dirty
then ag(ah)else ah.value end local ai,aj,ak,al=function(ai,aj)local ak=ah(ai)if
type(aj)=='table'then aj=aa(ak,aj)end if aj==ak then return false end ai.encode(
ai.components,aj)ai.value=aj ai.dirty=nil return true end,function(ai,aj)local
ak={}ai.encode(ak,aj)for al,am in ak do ai.components[al]+=am end ai.dirty=true
end,function(ai,aj)for ak,al in aj.components do ai.components[ak]=al end ai.
value=ah(aj)ai.dirty=nil end,function(ai,aj,ak,al)for am,an in ak.components do
local ao=(aj.components[am])ai.components[am]=ao+(an-ao)*al end ai.dirty=true
end return{create=ad,copy=ae,zero=af,setValue=ai,addValue=aj,getValue=ah,
recomputeValue=ag,assign=ak,lerp=al}end function a.cC()local ab=a.cache.cC if
not ab then ab={c=aa()}a.cache.cC=ab end return ab.c end end do local aa=
function()local aa=function(aa,ab)local ac,ad={},0 local ae=function(ae)local af
=table.find(ac,ae)if af then ac[af]=ac[ad]ac[ad]=nil ad-=1 end end local af,ag,
ah,ai=function(af)for ag=ad,1,-1 do ab(ac[ag],af,ae)end end,function(af,ag)
return ab(af,ag,ae)end,function(af)if table.find(ac,af)then return end table.
insert(ac,af)ad+=1 end,function()table.clear(ac)ad=0 end return{states=ac,update
=ag,step=af,add=ah,remove=ae,clear=ai}end return aa end function a.cD()local ab=
a.cache.cD if not ab then ab={c=aa()}a.cache.cD=ab end return ab.c end end do
local aa=function()local aa,ab=nil,(a.cz())local ac=function(ac,ad,...)aa=nil
ad(...)aa=ac end local ad=function()while true do ac(coroutine.yield())end end
local ae=function(ae,...)local af=aa or coroutine.create(ad)aa=nil coroutine.
resume(af,af,ae,...)end return ae end function a.cE()local ab=a.cache.cE if not
ab then ab={c=aa()}a.cache.cE=ab end return ab.c end end do local aa=function()
local aa=a.cE()local ab=function()local ab,ac={},0 local ad,ae=function(ad)table
.insert(ab,ad)ac+=1 return function()local ae=table.find(ab,ad)if ae then ab[ae]
=ab[ac]ab[ac]=nil ac-=1 end end end,function(...)for ad=ac,1,-1 do aa(ab[ad],...
)end end return ad,ae end return ab end function a.cF()local ab=a.cache.cF if
not ab then ab={c=aa()}a.cache.cF=ab end return ab.c end end do local aa=
function()return{}end function a.cG()local ab=a.cache.cG if not ab then ab={c=
aa()}a.cache.cG=ab end return ab.c end end do local aa=function()local aa,ab,ac,
ad=a.cC(),a.cD(),a.cF(),a.cG()local ae,af,ag,ah,ai=aa.getValue,aa.recomputeValue
,1e-3,62.5,{}(ai).__index=ai local aj=function(aj,ak)if type(aj)=='number'then
return math.abs(aj)<=ak else local al=vector.abs(aj)return math.max(al.x,al.y,al
.z)<=ak end end local ak,al=ab('Spring',function(ak,al,am)if ak.complete then
am(ak)return ae(ak.position)end local an,ao,ap,aq,ar,as,at=ak.position,ak.
velocity,ak.goal,ak.restPosition,ak.restVelocity,ak.dampingRatio,ak.frequency*2*
math.pi local au,av,aw,ax,ay=math.exp(-al*as*at),true,(an.components),(ao.
components),(ap.components)if as==1 then for az,aA in aw do local aB,aC=ax[az],
ay[az]local aD=aA-aC local aE,aF=(aB*al+aD*(at*al+1))*au+aC,(aB-at*al*(aD*at+aB)
)*au if av then av=aj(aE-aC,aq)and aj(aF,ar)end aw[az]=aE ax[az]=aF end elseif
as<1 then local az=(1-as*as)^0.5 local aA,aB,aC=math.cos(at*az*al),(math.sin(at*
az*al))if az>1e-4 then aC=aB/az else local aD=al*at aC=aD+((aD*aD)*(az*az)*(az*
az)/20-az*az)*(aD*aD*aD)/6 end local aD if at*az>1e-4 then aD=aB/(at*az)else
local aE=at*az aD=al+((al*al)*(aE*aE)*(aE*aE)/20-aE*aE)*(al*al*al)/6 end for aE,
aF in aw do local b,c=ax[aE],ay[aE]local d=aF-c local e,f=(d*(aA+as*aC)+b*aD)*au
+c,(b*(aA-aC*as)-d*(aC*at))*au if av then av=aj(e-c,aq)and aj(f,ar)end aw[aE]=e
ax[aE]=f end else local az=math.sqrt(as*as-1)local aA,aB=-at*(as-az),-at*(as+az)
local aC,aD=math.exp(aA*al),math.exp(aB*al)for aE,aF in aw do local b,c=ax[aE],
ay[aE]local d=aF-c local e=(b-d*aA)/(2*at*az)local f=aC*(d-e)local g,h=f+e*aD+c,
f*aA+e*aD*aB if av then av=aj(g-c,aq)and aj(h,ar)end aw[aE]=g ax[aE]=h end end
local az=if not av then af(an)else ae(ap)ao.dirty=true ak.complete=av ak.
fireChange(az,al)if av then am(ak)aa.assign(an,ap)aa.zero(ao)ak.fireComplete(az)
end return az end),function(ak,al)local am=al or{}local an,ao,ap=aa.create(am.
position or ak),ac()local aq,ar=ac()local as={position=an,velocity=aa.zero(aa.
copy(an)),goal=aa.copy(an),dampingRatio=1,frequency=1,restPosition=ag,
restVelocity=ag*ah,started=false,complete=true,onChange=ao,fireChange=ap,
onComplete=aq,fireComplete=ar}local at=(setmetatable({state=as},ai))at:
configure(am)if am.start then at:start()end return at end function ai:
scheduleUpdate()self.state.complete=false if self.state.started then ak.add(self
.state)end end function ai:start()self.state.started=true if not self.state.
complete then ak.add(self.state)end end function ai:stop()self.state.started=
false ak.remove(self.state)end function ai:idle()return self.state.complete end
function ai:step(am)return ak.update(self.state,am)end function ai:configure(am)
local an=self.state an.restPosition=am.precision or an.restPosition an.
restVelocity=am.restVelocity or an.restPosition*ah if am.dampingRatio or am.
frequency then an.dampingRatio=am.dampingRatio or an.dampingRatio an.frequency=
am.frequency or an.frequency else local ao,ap,aq=am.tension or 170,am.friction
or 26,am.mass or 1 an.dampingRatio=ap/(2*(aq*ao)^0.5)an.frequency=(ao/aq)^0.5/2/
math.pi end if am.velocity then self:setVelocity(am.velocity)end if am.impulse
then self:impulse(am.impulse)end if am.position then self:setPosition(am.
position)end end function ai:getPosition()return aa.getValue(self.state.position
)end function ai:getVelocity()return aa.getValue(self.state.velocity)end
function ai:getGoal()return aa.getValue(self.state.goal)end function ai:
setPosition(am)if aa.setValue(self.state.position,am)then self:scheduleUpdate()
self.state.fireChange(aa.getValue(self.state.position),0)end end function ai:
setVelocity(am)if aa.setValue(self.state.velocity,am)then self:scheduleUpdate()
end end function ai:setGoal(am,an)if an then self:configure(an)end if aa.
setValue(self.state.goal,am)then self:scheduleUpdate()end end function ai:
impulse(am)aa.addValue(self.state.velocity,am)self:scheduleUpdate()end function
ai:halt()aa.zero(self.state.velocity)end function ai:onChange(am)return self.
state.onChange(am)end function ai:onComplete(am)return self.state.onComplete(am)
end function ai:destroy()self:stop()end return{scheduler=ak,createSpring=al}end
function a.cH()local ab=a.cache.cH if not ab then ab={c=aa()}a.cache.cH=ab end
return ab.c end end do local aa=function()a.cH()return{default={tension=170,
friction=26},gentle={tension=120,friction=14},wobbly={tension=180,friction=12},
stiff={tension=210,friction=20},slow={tension=280,friction=60},molasses={tension
=280,friction=120},figmaGentle={tension=100,friction=15},figmaQuick={tension=300
,friction=20},figmaBouncy={tension=600,friction=15},figmaSlow={tension=80,
friction=20}}end function a.cI()local ab=a.cache.cI if not ab then ab={c=aa()}a.
cache.cI=ab end return ab.c end end do local aa=function()local aa,ab=math.pi,
1.70158 local ac,ad,ae,af,ag,ah,ai,aj,ak,al,am,an,ao,ap,aq,ar,as,at,au,av,aw,ax,
ay,az,aA,aB,aC,aD=ab*1.525,ab+1,(2*aa)/3,(2*aa)/4.5,function(ac)return ac end,
function(ac)return if ac==0 then 0 else 1 end,function(ac)return ac*ac*(3-2*ac)
end,function(ac)return ac*ac end,function(ac)return 1-(1-ac)*(1-ac)end,function(
ac)return if ac<0.5 then 2*ac*ac else 1-((-2*ac+2)^2)/2 end,function(ac)return
ac*ac*ac end,function(ac)return 1-(1-ac)^3 end,function(ac)return if ac<0.5 then
4*ac*ac*ac else 1-((-2*ac+2)^3)/2 end,function(ac)return ac*ac*ac*ac end,
function(ac)return 1-(1-ac)^4 end,function(ac)return if ac<0.5 then 8*ac*ac*ac*
ac else 1-((-2*ac+2)^4)/2 end,function(ac)return ac*ac*ac*ac*ac end,function(ac)
return 1-(1-ac)^5 end,function(ac)return if ac<0.5 then 16*ac*ac*ac*ac*ac else 1
-((-2*ac+2)^5)/2 end,function(ac)return 1-math.cos((ac*aa)/2)end,function(ac)
return math.sin((ac*aa)/2)end,function(ac)return-(math.cos(aa*ac)-1)/2 end,
function(ac)return if ac==0 then 0 else 2^(10*ac-10)end,function(ac)return if ac
==1 then 1 else 1-2^(-10*ac)end,function(ac)return if ac==0 then 0 elseif ac==1
then 1 elseif ac<0.5 then(2^(20*ac-10))/2 else(2-(2^(-20*ac+10)))/2 end,function
(ac)return 1-(1-(ac^2))^0.5 end,function(ac)return(1-(ac-1)^2)^0.5 end,function(
ac)return if ac<0.5 then(1-(1-((2*ac)^2))^0.5)/2 else(((1-((-2*ac+2)^2))^0.5)+1)
/2 end local aE,aF,b,c,d,e,f=function(aE)return ad*aE*aE*aE-ab*aE*aE end,
function(aE)return 1+ad*((aE-1)^3)+ab*((aE-1)^2)end,function(aE)return if aE<0.5
then(((2*aE)^2)*((ac+1)*2*aE-ac))/2 else(((2*aE-2)^2)*((ac+1)*(aE*2-2)+ac)+2)/2
end,function(aE)return if aE==0 then 0 elseif aE==1 then 1 else-(2^(10*aE-10))*
math.sin((aE*10-10.75)*ae)end,function(aE)return if aE==0 then 0 elseif aE==1
then 1 else(2^(-10*aE))*math.sin((aE*10-0.75)*ae)+1 end,function(aE)return if aE
==0 then 0 elseif aE==1 then 1 elseif aE<0.5 then-((2^(20*aE-10))*math.sin((20*
aE-11.125)*af))/2 else((2^(-20*aE+10))*math.sin((20*aE-11.125)*af))/2+1 end,
function(aE)local aF,b=7.5625,2.75 if aE<1/b then return aF*aE*aE elseif aE<2/b
then aE-=1.5/b return aF*aE*aE+0.75 elseif aE<2.5/b then aE-=2.25/b return aF*aE
*aE+0.9375 else aE-=2.625/b return aF*aE*aE+0.984375 end end local g,h=function(
g)return 1-f(1-g)end,function(g)return if g<0.5 then(1-f(1-2*g))/2 else(1+f(2*g-
1))/2 end return{linear=ag,instant=ah,smoothstep=ai,quadIn=aj,quadOut=ak,
quadInOut=al,cubicIn=am,cubicOut=an,cubicInOut=ao,quartIn=ap,quartOut=aq,
quartInOut=ar,quintIn=as,quintOut=at,quintInOut=au,sineIn=av,sineOut=aw,
sineInOut=ax,expoIn=ay,expoOut=az,expoInOut=aA,circIn=aB,circOut=aC,circInOut=aD
,backIn=aE,backOut=aF,backInOut=b,elasticIn=c,elasticOut=d,elasticInOut=e,
bounceIn=g,bounceOut=f,bounceInOut=h}end function a.cJ()local ab=a.cache.cJ if
not ab then ab={c=aa()}a.cache.cJ=ab end return ab.c end end do local aa=
function()local aa,ab=a.cG(),function(aa,ab,ac)local ad=typeof(aa)if ad==
'number'or ad=='vector'then return aa+(ab-aa)*ac elseif ad=='table'then local ae
=aa for af,ag in ab do local ah=aa[af]if not ah then continue end local ai=ah+(
ag-ah)*ac if ae[af]~=ai then if ae==aa then ae=table.clone(aa)end ae[af]=ai end
end return ae else error(`Unsupported type for interpolation: {ad}`)end end
return ab end function a.cK()local ab=a.cache.cK if not ab then ab={c=aa()}a.
cache.cK=ab end return ab.c end end do local aa=function()local aa,ab,ac,ad,ae,
af,ag=a.cJ(),a.cK(),a.cB(),a.cD(),a.cF(),a.cG(),{}(ag).__index=ag local ah=
function(ah,ai,aj)if ai<0 then ai=math.huge end if ai>1 and ah>=1 then if aj
then return math.abs((ah-1)%2-1)elseif ah<ai then return ah%1 end return 1 end
return ah end local ai,aj=ad('Tween',function(ai,aj,ak)if ai.complete then ak(ai
)return ai.position end ai.elapsed+=aj local al=math.clamp(ai.elapsed/ai.
duration,0,ai.repeats)if al~=al then al=ai.repeats end local am=ah(al,ai.repeats
,ai.reverses)local an=if am>0 and am<1 then ai.easingFunction(am)else am local
ao=ab(ai.from,ai.goal,an)ai.position=ao ai.fireChange(ao,aj)if al==ai.repeats
then ak(ai)ai.complete=true ai.fireComplete(ao)end return ao end),function(ai,aj
)local ak=aj or{}local al,am,an=ak.position or ai,ae()local ao,ap=ae()local aq={
position=al,from=al,goal=al,easingFunction=aa.linear,duration=1,repeats=1,
reverses=false,elapsed=0,started=false,complete=true,onChange=am,fireChange=an,
onComplete=ao,fireComplete=ap}local ar=(setmetatable({state=aq},ag))ar:
configure(ak)if ak.start then ar:start()end return ar end function ag:
resumeFromCurrentPosition()local ak=self.state ak.complete=false ak.elapsed=0 ak
.from=ak.position if ak.started then ai.add(ak)end end function ag:start()self.
state.started=true if not self.state.complete then ai.add(self.state)end end
function ag:stop()self.state.started=false ai.remove(self.state)end function ag:
idle()return self.state.complete end function ag:step(ak)return ai.update(self.
state,ak)end function ag:configure(ak)local al=self.state al.easingFunction=aa[
ak.easing]or al.easingFunction al.duration=ak.duration or al.duration al.repeats
=ak.repeats or al.repeats al.reverses=ak.reverses or al.reverses if ak.position
then self:setPosition(ak.position)end if not al.complete and al.elapsed~=0 then
self:resumeFromCurrentPosition()end end function ag:getPosition()return self.
state.position end function ag:getFrom()return self.state.from end function ag:
getGoal()return self.state.goal end function ag:setPosition(ak)local al=if type(
ak)=='table'then ac(self.state.position,ak)else ak if self.state.position~=al
then self.state.position=al self:resumeFromCurrentPosition()self.state.
fireChange(al,0)end end function ag:setGoal(ak,al)if al then self:configure(al)
end local am=if type(ak)=='table'then ac(self.state.goal,ak)else ak if self.
state.goal~=am then self.state.goal=am self:resumeFromCurrentPosition()end end
function ag:onChange(ak)return self.state.onChange(ak)end function ag:onComplete
(ak)return self.state.onComplete(ak)end function ag:destroy()self:stop()end
return{scheduler=ai,createTween=aj}end function a.cL()local ab=a.cache.cL if not
ab then ab={c=aa()}a.cache.cL=ab end return ab.c end end do local aa=function()
local aa,ab,ac,ad,ae,af=a.cD(),a.cF(),a.cH(),a.cL(),a.cG(),{}(af).__index=af
local ag,ah=aa('Motion',function(ag,ah,ai)if ag.complete then ai(ag)return ag.
current:getPosition()end local aj=ag.current:step(ah)if ag.current:idle()then
ai(ag)ag.complete=true ag.fireComplete(aj)end return aj end),function(ag)local
ah=ag if ah==nil or ah.start~=true then return ah else local ai=table.clone(ah)
ai.start=nil return ai end end local ai=function(ai,aj)local ak=aj or{}local al,
am=ac.createSpring(ai,ah(ak.spring)),ad.createTween(ai,ah(ak.tween))local an,ao,
ap=if not ak.tween then al else am,ab()local aq,ar=ab()local as={spring=al,tween
=am,current=an,started=false,complete=true,onChange=ao,onComplete=aq,
fireComplete=ar}local at=(setmetatable({state=as},af))if ak.start then at:start(
)end al:onChange(function(au,av)if as.current==al then ap(au,av)end end)am:
onChange(function(au,av)if as.current==am then ap(au,av)end end)return at end
function af:scheduleUpdate()self.state.complete=false if self.state.started then
ag.add(self.state)end end function af:prepareSpring()local aj=self.state if aj.
current~=aj.spring then aj.spring:setPosition(aj.tween:getPosition())aj.current=
aj.spring end end function af:prepareTween()local aj=self.state if aj.current~=
aj.tween then aj.tween:setPosition(aj.spring:getPosition())aj.spring:halt()aj.
current=aj.tween end end function af:start()self.state.started=true if not self.
state.complete then ag.add(self.state)end end function af:stop()self.state.
started=false ag.remove(self.state)end function af:idle()return self.state.
complete end function af:step(aj)return ag.update(self.state,aj)end function af:
configure(aj)if aj.spring then self.state.spring:configure(aj.spring)end if aj.
tween then self.state.tween:configure(aj.tween)end if not self.state.current:
idle()then self:scheduleUpdate()end end function af:getPosition()return self.
state.current:getPosition()end function af:getVelocity()return self.state.spring
:getVelocity()end function af:getGoal()return self.state.current:getGoal()end
function af:setPosition(aj)self.state.current:setPosition(aj)if not self.state.
current:idle()then self:scheduleUpdate()end end function af:setVelocity(aj)if
self.state.current==self.state.spring then self.state.spring:setVelocity(aj)if
not self.state.current:idle()then self:scheduleUpdate()end end end function af:
setGoal(aj,ak)if ak then if ak.spring then return self:spring(aj,ak.spring)
elseif ak.tween then return self:tween(aj,ak.tween)end end self.state.current:
setGoal(aj)if not self.state.current:idle()then self:scheduleUpdate()end end
function af:spring(aj,ak)self:prepareSpring()self.state.spring:setGoal(aj,ak)if
not self.state.spring:idle()then self:scheduleUpdate()end end function af:tween(
aj,ak)self:prepareTween()self.state.tween:setGoal(aj,ak)if not self.state.tween:
idle()then self:scheduleUpdate()end end function af:onChange(aj)return self.
state.onChange(aj)end function af:onComplete(aj)return self.state.onComplete(aj)
end function af:destroy()self:stop()end return{scheduler=ag,createMotion=ai}end
function a.cM()local ab=a.cache.cM if not ab then ab={c=aa()}a.cache.cM=ab end
return ab.c end end do local aa=function()local aa,ab,ac,ad,ae,af=a.cI(),a.cJ(),
a.cM(),a.cH(),a.cL(),a.cG()return{config=aa,easing=ab,createMotion=ac.
createMotion,motionScheduler=ac.scheduler,createSpring=ad.createSpring,
springScheduler=ad.scheduler,createTween=ae.createTween,tweenScheduler=ae.
scheduler}end function a.cN()local ab=a.cache.cN if not ab then ab={c=aa()}a.
cache.cN=ab end return ab.c end end do local aa=function()local aa=a.cN()return
aa end function a.cO()local ab=a.cache.cO if not ab then ab={c=aa()}a.cache.cO=
ab end return ab.c end end do local aa=function()local aa=a.a()local ab,ac,ad,ae
,af,ag,ah,ai,aj=aa.GuiService,aa.UserInputService,aa.RunService,aa.Lighting,a.
cA(),a.cO(),a.c(),300,{Enum.UserInputType.MouseButton1,Enum.UserInputType.
MouseButton2,Enum.UserInputType.Touch}local ak,al,am={Valid=true,AutoComplete=
nil,ProcessEntry=nil,OnTextChanged=nil,CoCo=nil,GuiRoot=nil,HistoryState=nil,
Janitor=af.new(),LastLineText=nil,LastLineGui=nil,DuplicateCount=0},-80,25 local
an,ao,ap,aq,ar,as,at,au,av=ag.createSpring(al,{frequency=4,dampingRatio=0.75}),
ag.createSpring(1,{frequency=4,dampingRatio=0.8}),ag.createSpring(0,{frequency=5
,dampingRatio=0.8}),55,12,ag.createSpring(70,{frequency=4,dampingRatio=0.8}),ag.
createSpring(0,{frequency=4,dampingRatio=0.8}),70,Instance.new'BlurEffect'av.
Size=0 av.Parent=ae local aw,ax,ay=0,false,function()local aw=ak.GuiRoot if not
aw then return nil end local ax=aw:WaitForChild'CoCo':WaitForChild'Frame'return
ax end function ak:getGui()return ay()end local az,aA=function()local az=ay()
return az and az:FindFirstChild'Line'end,function()local az=ay()return az and az
:FindFirstChild'Entry'end function ak:updateLabel()local aB=aA()if aB then aB.
TextLabel.Text='CoCo$'end end function ak:getLabel()local aB=aA()return aB and
aB.TextLabel.Text or'CoCo$'end function ak:updateWindowHeight()local aB=ay()if
not aB then return end aw=aB.UIListLayout.AbsoluteContentSize.Y+aB.UIPadding.
PaddingTop.Offset+aB.UIPadding.PaddingBottom.Offset local aC=math.clamp(aw,0,ai)
if math.abs(ap:getPosition()-aC)>0.5 then ap:setGoal(aC)end end function ak:
addLine(aB,aC)aC=aC or{}aB=tostring(aB)if typeof(aC)=='Color3'then aC={Color=aC}
end if#aB==0 then ak:updateWindowHeight()return end if aB==ak.LastLineText then
ak.DuplicateCount+=1 if ak.LastLineGui then ak.LastLineGui.Text=aB..' x'..(ak.
DuplicateCount+1)end ak:updateWindowHeight()return end ak.LastLineText=aB ak.
DuplicateCount=0 local aD=ay()if not aD then return end local aE=az()if not aE
then return end local aF,b=ah.emulateTabstops(aB,8),aE:Clone()b.Text=aF b.
TextColor3=aC.Color or b.TextColor3 b.RichText=aC.RichText or false b.Parent=aD
ak.LastLineGui=b end function ak:isVisible()local aB=ay()if not aB then return
false end if ax then return false end return aB.Visible end function ak:
setVisible(aB)local aC=ay()if not aC then return end if aB then ax=false an:
setPosition(al)ao:setPosition(1)aC.Position=UDim2.new(0.025,0,0,am+al)aC.
BackgroundTransparency=1 aC.Visible=true an:setGoal(0)ao:setGoal(0.4)local aD=
workspace.CurrentCamera if aD then au=aD.FieldOfView as:setPosition(au)at:
setPosition(0)as:setGoal(aq)at:setGoal(ar)end else ax=true an:setGoal(al)ao:
setGoal(1)as:setGoal(au)at:setGoal(0)end local aD=aA()if aB and aD then aD.
TextBox:CaptureFocus()self:setEntryText''if self.CoCo.ActivationUnlocksMouse
then self.PreviousMouseBehavior=ac.MouseBehavior ac.MouseBehavior=Enum.
MouseBehavior.Default end elseif aD then aD.TextBox.Text=''aD.TextBox:
ReleaseFocus()self.AutoComplete:hide()if self.PreviousMouseBehavior then ac.
MouseBehavior=self.PreviousMouseBehavior self.PreviousMouseBehavior=nil end end
end function ak:hide()return self:setVisible(false)end function ak:show()return
self:setVisible(true)end function ak:setEntryText(aB)local aC=aA()if not aC then
return end aC.TextBox.Text=aB if self:isVisible()then aC.TextBox:CaptureFocus()
if#aB>0 then aC.TextBox.CursorPosition=#aB+1 end ak:updateWindowHeight()end if#
aB==0 then local aD aD=aC.TextBox:GetPropertyChangedSignal'Text':Connect(
function()aD:Disconnect()if aC.TextBox.Text~=''then aC.TextBox.Text=''end end)
task.defer(function()if aD then aD:Disconnect()end end)end end function ak:
getEntryText()local aB=aA()if not aB then return''end return aB.TextBox.Text:
gsub('\t','')end function ak:setIsValidInput(aB,aC)local aD=aA()if not aD then
return end aD.TextBox.TextColor3=aB and Color3.fromRGB(255,255,255)or Color3.
fromRGB(255,73,73)self.Valid=aB self._errorText=aC end function ak:
hideInvalidState()local aB=aA()if aB then aB.TextBox.TextColor3=Color3.fromRGB(
255,255,255)end end function ak:loseFocus(aB)local aC=self:getEntryText()if aB
then local aD=self.AutoComplete and self.AutoComplete:getSelectedItem()if aD
then local aE=aC:match'^(.*)[%s]'if aE then if aE~=aD[2]then aC=aE..' '..aD[2]
end else aC=aD[2]end self:setEntryText(aC)aC=self:getEntryText()end if self.
Valid then task.wait()self:setEntryText''self.ProcessEntry(aC)else self:addLine(
self._errorText,Color3.fromRGB(255,153,153))task.wait()self:setEntryText''end
for aE=1,5 do task.defer(function()local aF=aA()if aF and aF.TextBox.Text:match
'^%s'then aF.TextBox.Text=aF.TextBox.Text:gsub('^%s+','')end end)end local aE=
ay()if aE then aE.CanvasPosition=Vector2.new(0,aE.AbsoluteCanvasSize.Y)end
return end self:clearHistoryState()local aD=ay()if aD and self:isVisible()and
not ab.MenuIsOpen then local aE=aA()if aE then aE.TextBox:CaptureFocus()end
elseif ab.MenuIsOpen and aD and aD.Visible then self:hide()end end function ak:
traverseHistory(aB)local aC=self.CoCo.Dispatcher:getHistory()if self.
HistoryState==nil then self.HistoryState={Position=#aC+1,InitialText=self:
getEntryText()}end self.HistoryState.Position=math.clamp(self.HistoryState.
Position+aB,1,#aC+1)self:setEntryText(self.HistoryState.Position==#aC+1 and self
.HistoryState.InitialText or aC[self.HistoryState.Position])end function ak:
clearHistoryState()self.HistoryState=nil end function ak:selectVertical(aB)if
self.AutoComplete:isVisible()and not self.HistoryState then self.AutoComplete:
select(aB)else self:traverseHistory(aB)end end local aB,aC=0,0 function ak:
beginInput(aD,aE)if ab.MenuIsOpen then self:hide()end if aE and self:isVisible()
==false then return end if self.CoCo.ActivationKeys[aD.KeyCode]then if self.CoCo
.MashToEnable and not self.CoCo.Enabled then if os.clock()-aB<1 then if aC>=5
then return self.CoCo:setEnabled(true)else aC+=1 end else aC=1 end aB=os.clock()
elseif self.CoCo.Enabled then self:setVisible(not self:isVisible())task.wait()
self:setEntryText''if ab.MenuIsOpen then self:hide()end end return end if self.
CoCo.Enabled==false or not self:isVisible()then if self:isVisible()then self:
hide()end return end if self.CoCo.HideOnLostFocus and table.find(aj,aD.
UserInputType)then local aF=ay()if not aF then return end local b,c,d=aD.
Position,aF.AbsolutePosition,aF.AbsoluteSize if b.X<c.X or b.X>c.X+d.X or b.Y<c.
Y or b.Y>c.Y+d.Y then self:hide()end elseif aD.KeyCode==Enum.KeyCode.Down then
self:selectVertical(1)elseif aD.KeyCode==Enum.KeyCode.Up then self:
selectVertical(-1)elseif aD.KeyCode==Enum.KeyCode.Return then if self.
AutoComplete and self.AutoComplete:isVisible()then local aF=self.AutoComplete:
getSelectedItem()if aF then local b=self:getEntryText()local c=b:match
'^(.*)[%s]'if c then if c~=aF[2]then b=c..' '..aF[2]end else b=aF[2]end self:
setEntryText(b)end end return elseif aD.KeyCode==Enum.KeyCode.Tab then local aF,
b=self.AutoComplete:getSelectedItem(),self:getEntryText()if aF and not(b:sub(#b,
#b):match'%s'and self.AutoComplete.LastItem)then local c,d,e,f=aF[2],true,(self.
AutoComplete.Command)if e then local g=self.AutoComplete.Arg f=e.Alias d=self.
AutoComplete.NumArgs~=#e.ArgumentDefinitions and self.AutoComplete.IsPartial==
false local h=e.Arguments for i=1,#h do local j=h[i]local l=j.RawSegments if j==
g then l[#l]=c end local m=j.Prefix..table.concat(l,',')if m:find' 'or m==''then
m=('%q'):format(m)end f=('%s %s'):format(f,m)if j==g then break end end else f=c
end task.wait()self:setEntryText(f..(d and' 'or''))else task.wait()self:
setEntryText(self:getEntryText())end else self:clearHistoryState()end end
function ak:destroy()self.Janitor:Destroy()av:Destroy()end local aD=function()
local aD=aA()if not aD then return end ak.Janitor:Add(aD.TextBox.FocusLost:
Connect(function(aE)return ak:loseFocus(aE)end),'Disconnect')ak.Janitor:Add(ac.
InputBegan:Connect(function(aE,aF)return ak:beginInput(aE,aF)end),'Disconnect')
ak.Janitor:Add(aD.TextBox:GetPropertyChangedSignal'Text':Connect(function()local
aE=ay()if not aE then return end aE.CanvasPosition=Vector2.new(0,aE.
AbsoluteCanvasSize.Y)if aD.TextBox.Text:match'\t'then aD.TextBox.Text=aD.TextBox
.Text:gsub('\t','')return end if aD.TextBox.Text:match'^%s'then aD.TextBox.Text=
aD.TextBox.Text:gsub('^%s+','')return end if ak.OnTextChanged then return ak.
OnTextChanged(aD.TextBox.Text)end end),'Disconnect')local aE=ay()if aE then ak.
Janitor:Add(aE.ChildAdded:Connect(function()task.defer(ak.updateWindowHeight)end
),'Disconnect')end ak.Janitor:Add(ad.Heartbeat:Connect(function(aF)local b=ay()
if not b then return end local c,d,e,f,g=an:step(aF),ao:step(aF),ap:step(aF),as:
step(aF),at:step(aF)b.Position=UDim2.new(0.025,0,0,am+c)b.BackgroundTransparency
=d b.Size=UDim2.new(b.Size.X.Scale,b.Size.X.Offset,0,e)local h=workspace.
CurrentCamera if h then h.FieldOfView=f end av.Size=g if not ap:idle()then b.
CanvasPosition=Vector2.new(0,aw)end if b.Visible then local i=math.clamp((d-0.4)
/0.6,0,1)for j,l in ipairs(b:GetDescendants())do if l:IsA'TextBox'or l:IsA
'TextLabel'then l.TextTransparency=i end end end if an:idle()and ax then ax=
false b.Visible=false end end),'Disconnect')end task.spawn(function()while not
ay()do task.wait()end aD()end)return ak end function a.cP()local ab=a.cache.cP
if not ab then ab={c=aa()}a.cache.cP=ab end return ab.c end end do local aa=
function()return function(aa,ab)local ac,ad,ae=a.c(),a.cA(),a.a()local af,ag,ah=
ae.TweenService,{Items={},ItemOptions={},SelectedItem=0,Janitor=ad.new()},ab:
WaitForChild'Autocomplete'local ai,aj,ak,al=ah:WaitForChild'TextButton',ah:
WaitForChild'Title',ah:WaitForChild'Description',ab:WaitForChild'Frame':
WaitForChild'Entry'ai.Parent=nil local am,an,ao,ap=ah.ScrollBarThickness,
TweenInfo.new(0.08,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),function(am,
an,ao,ap)am.Visible=ao~=nil an.Text=ao or''if ap then an.Size=UDim2.new(0,an.
TextBounds.X,am.Size.Y.Scale,am.Size.Y.Offset)end end,10 local aq=function()ah.
Size=UDim2.new(0,math.max(aj.Field.TextBounds.X+aj.Field.Type.TextBounds.X+ap,ah
.Size.X.Offset),0,math.min(ah.UIListLayout.AbsoluteContentSize.Y,ah.Parent.
AbsoluteSize.Y-ah.AbsolutePosition.Y-ap))end local ar=function(ar)ao(aj,aj.Field
,ar.name,true)ao(aj.Field.Type,aj.Field.Type,ar.type and': '..ar.type:sub(1,1):
upper()..ar.type:sub(2),true)aj.Field.Type.Position=UDim2.new(0,aj.Field.Size.X.
Offset,0,0)ao(ak,ak.Label,ar.description)ak.Label.TextColor3=ar.invalid and
Color3.fromRGB(255,73,73)or Color3.fromRGB(255,255,255)ak.Size=UDim2.new(1,0,0,
40)while not ak.Label.TextFits do ak.Size=ak.Size+UDim2.new(0,0,0,2)if ak.Size.Y
.Offset>500 then break end end ah.UIListLayout:ApplyLayout()aq()ah.
ScrollBarThickness=am end function ag:show(as,at)at=at or{}for au,av in ipairs(
self.Items)do if av.gui then av.gui:Destroy()end end self.SelectedItem=1 self.
Items=as self.Prefix=at.prefix or''self.LastItem=at.isLast or false self.Command
=at.command self.Arg=at.arg self.NumArgs=at.numArgs self.IsPartial=at.isPartial
local au=200 ah.ScrollBarThickness=0 for av,aw in ipairs(self.Items)do local ax,
ay=aw[1],aw[3]or aw[2]local az,aA=ay,ai:Clone()aA.Name=ax..tostring(az)aA.
BackgroundTransparency=av==self.SelectedItem and 0.5 or 1 local aB,aC=string.
find(az:lower(),ax:lower(),1,true)if not aB then aA.Typed.Text=''aA.Suggest.Text
=az else aA.Typed.Text=string.rep(' ',aB-1)..ax aA.Suggest.Text=string.sub(az,0,
aB-1)..string.rep(' ',#ax)..string.sub(az,aC+1)end aA.Parent=ah aA.LayoutOrder=
av local aD=math.max(aA.Typed.TextBounds.X,aA.Suggest.TextBounds.X)+20 if aD>au
then au=aD end aw.gui=aA end ah.UIListLayout:ApplyLayout()for av,aw in ipairs(
self.Items)do if aw.gui then local ax=aw.gui.BackgroundTransparency aw.gui.
BackgroundTransparency=1 af:Create(aw.gui,an,{BackgroundTransparency=ax}):Play()
end end af:Create(ah,an,{BackgroundTransparency=0.5}):Play()for av,aw in ipairs(
ah:GetDescendants())do if aw:IsA'TextLabel'or aw:IsA'TextBox'then aw.
TextTransparency=1 af:Create(aw,an,{TextTransparency=0}):Play()end end local av=
al.TextBox.Text local aw=ac.splitString(av)if av:sub(#av,#av)==' 'and not at.at
then aw[#aw+1]='e'end table.remove(aw,#aw)local ax=(at.at and at.at or(#table.
concat(aw,' ')+1))*7 ah.Position=UDim2.new(0,al.TextBox.AbsolutePosition.X-10+ax
,0,al.TextBox.AbsolutePosition.Y+30)ah.Size=UDim2.new(0,au,0,ah.UIListLayout.
AbsoluteContentSize.Y)ah.Visible=true ar(self.Items[1]and self.Items[1].options
or at)end function ag:getSelectedItem()if ah.Visible==false then return nil end
return ag.Items[ag.SelectedItem]end function ag:hide()local as=af:Create(ah,
TweenInfo.new(0.06,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
BackgroundTransparency=1})as.Completed:Connect(function()ah.Visible=false end)as
:Play()for at,au in ipairs(self.Items)do if au.gui then af:Create(au.gui,
TweenInfo.new(0.06,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
BackgroundTransparency=1}):Play()end end for at,au in ipairs(ah:GetDescendants()
)do if au:IsA'TextLabel'or au:IsA'TextBox'then af:Create(au,TweenInfo.new(0.06,
Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=1}):Play()end
end end function ag:isVisible()return ah.Visible end function ag:select(as)if
not ah.Visible then return end self.SelectedItem=self.SelectedItem+as if self.
SelectedItem>#self.Items then self.SelectedItem=1 elseif self.SelectedItem<1
then self.SelectedItem=#self.Items end for at,au in ipairs(self.Items)do au.gui.
BackgroundTransparency=at==self.SelectedItem and 0.5 or 1 end ah.CanvasPosition=
Vector2.new(0,math.max(0,aj.Size.Y.Offset+ak.Size.Y.Offset+self.SelectedItem*ai.
Size.Y.Offset-ah.Size.Y.Offset))if self.Items[self.SelectedItem]and self.Items[
self.SelectedItem].options then ar(self.Items[self.SelectedItem].options or{})
end end ag.Janitor:Add(ah.Parent:GetPropertyChangedSignal'AbsoluteSize':Connect(
aq),'Disconnect')function ag:destroy()self.Janitor:Destroy()end return ag end
end function a.cQ()local ab=a.cache.cQ if not ab then ab={c=aa()}a.cache.cQ=ab
end return ab.c end end do local aa=function()local aa=a.c()return function(ab,
ac)local ad=a.cP()ad.CoCo=ab ad.GuiRoot=ac local ae=ac:FindFirstChild'CoCo'local
af=a.cQ()(ab,ae or ac)ad.AutoComplete=af function ad.ProcessEntry(ag)ag=aa.
trimString(ag)if#ag==0 then return end ad:addLine(ad:getLabel()..' '..ag,Color3.
fromRGB(255,223,93))ad:addLine(ab.Dispatcher:evaluateAndRun(ag))end local ag,ah=
0.3 function ad.OnTextChanged(ai)local aj,ak=ab.Dispatcher:evaluate(ai,ab.
Dispatcher._defaultExecutor,true),aa.splitString(ai)local al,am=table.remove(ak,
1),false if aj then ak=aa.mashExcessArguments(ak,#aj.Object.Args)am=#ak==#aj.
Object.Args end local an=al and#ak>0 if ai:sub(#ai,#ai):match'%s'and not am then
an=true ak[#ak+1]=''end if aj and an then local ao,ap=aj:validate()ad:
setIsValidInput(ao,('Validation errors: %s'):format(ap or''))local aq,ar=
function()local aq,ar=ab.Dispatcher:evaluate(ai,ab.Dispatcher._defaultExecutor,
true),aa.splitString(ai)local as,at=table.remove(ar,1),false if aq then ar=aa.
mashExcessArguments(ar,#aq.Object.Args)at=#ar==#aq.Object.Args end local au=as
and#ar>0 if ai:sub(#ai,#ai):match'%s'and not at then au=true ar[#ar+1]=''end if
aq and au then local av,aw={},aq:getArgument(#ar)if aw then local ax,ay=aw.
TextSegmentInProgress,false if aw.RawSegmentsAreAutocomplete then for az,aA in
ipairs(aw.RawSegments)do av[az]={aA,aA}end else local az,aA=aw:GetAutocomplete()
aA=aA or{}ay=aA.IsPartial or false for aB,aC in ipairs(az)do if type(aC)==
'table'then av[aB]={ax,aC.title,aC.name or aC.title,options={name=aC.name or aC.
title,type='Script',description=aC.metaDesc}}else av[aB]={ax,aC}end end end af:
show(av,{at=at and#ai-#ax+(ai:sub(#ai,#ai):match'%s'and-1 or 0),prefix=#aw.
RawSegments==1 and aw.Prefix or'',isLast=#aq.Arguments==#aq.ArgumentDefinitions
and#ax>0,numArgs=#ar,command=aq,arg=aw,name=aw.Name..(aw.Required and''or'?'),
type=aw.Type.DisplayName,description=aw.Object.Description,isPartial=ay})end end
end,aj:getArgument(#ak)if ar and ar.Type and ar.Type.Debounce then if ah then
task.cancel(ah)end af:hide()ah=task.delay(ag,function()ah=nil aq()end)else if ah
then task.cancel(ah)ah=nil end aq()end elseif al and#ak==0 then ad:
setIsValidInput(true)local ao,ap=(ab.Registry:getCommand(al))if ao then ap={ao.
Name,ao.Name,options={name=ao.Name,description=ao.Description}}local aq=ao.Args
and ao.Args[1]if type(aq)=='function'then aq=aq(aj)end if aq and(not aq.Optional
and aq.Default==nil)then ad:setIsValidInput(false,
'This command has required arguments.')ad:hideInvalidState()end end local aq,ar=
ap and{ap}or{},{}if ao then ar[ao]=true end for as,at in ipairs(ab.Registry:
getCommandNames())do if al:lower()==at:lower():sub(1,#al)then local au=ab.
Registry:getCommand(at)if au and not ar[au]then ar[au]=true aq[#aq+1]={al,at,
options={name=au.Name,description=au.Description}}end end end if#aq>0 then
return af:show(aq)end ad:setIsValidInput(false,(
[[%q is not a valid command name. Use the help command to see all available commands.]]
):format(al))af:hide()else if ah then task.cancel(ah)ah=nil end ad:
setIsValidInput(false,'Use the help command to see all available commands.')af:
hide()end end ad:updateLabel()ad:updateWindowHeight()return{Window=ad,
AutoComplete=af}end end function a.cR()local ab=a.cache.cR if not ab then ab={c=
aa()}a.cache.cR=ab end return ab.c end end do local aa=function()local aa,ab=a.
a(),a.cP()return function(ac,ad)ac.Events.Message:Connect(function(ae)local af=
pcall(function()aa.StarterGui:SetCore('ChatMakeSystemMessage',{Text=(
'[Announcement] %s'):format(ae),Color=Color3.fromRGB(249,217,56)})end)if not af
then warn'CoCo: Failed to send chat announcement message.'end end)ac.Events.
AddLine:Connect(function(...)ab:addLine(...)end)end end function a.cS()local ab=
a.cache.cS if not ab then ab={c=aa()}a.cache.cS=ab end return ab.c end end do
local aa=function()local aa,ab=a.d(),a.ao()return function(ac,ad)local ae=a.cR(
)(ac,ad)ac.ActivationKeys={[Enum.KeyCode.F2]=true}ac.Enabled=true ac.
MashToEnable=false ac.ActivationUnlocksMouse=false ac.HideOnLostFocus=true ac.
PlaceName='CoCo'ac.Events={AddLine=ab.new(),Message=ab.new()}function ac:
setActivationKeys(af)self.ActivationKeys=aa.makeDictionary(af)end function ac:
setPlaceName(af)self.PlaceName=af ae.Window:updateLabel()end function ac:
setEnabled(af)self.Enabled=af end function ac:setActivationUnlocksMouse(af)self.
ActivationUnlocksMouse=af end function ac:show()if not self.Enabled then return
end ae.Window:show()end function ac:hide()ae.Window:hide()end function ac:toggle
()if not self.Enabled then return self:hide()end ae.Window:setVisible(not ae.
Window:isVisible())end function ac:setMashToEnable(af)self.MashToEnable=af if af
then self:setEnabled(false)end end function ac:setHideOnLostFocus(af)self.
HideOnLostFocus=af end function ac:handleEvent(af,ag)if self.Events[af]then
return self.Events[af]:Connect(ag)end end a.cS()(ac,ad)return ae end end
function a.cT()local ab=a.cache.cT if not ab then ab={c=aa()}a.cache.cT=ab end
return ab.c end end end local aa,ab=a.cw(),pcall(gethui)and gethui()local ac=ab
and ab:FindFirstChild'CoCo'if not ac then local ad=os.clock()while not ac and os
.clock()-ad<5 do ac=ab and ab:FindFirstChild'CoCo'task.wait()end end a.cT()(aa,
ab or game:GetService'CoreGui')return aa
