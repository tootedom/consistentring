--
--
-- test.lua
package.path = package.path .. ';' .. arg[0]:gsub('[^\\/]+$', '') .. '?.lua'

luaunit = require('utils/luaunit')
require('org/greencheek/continuum')
local jenkins = require("org/greencheek/hashing/jenkins")


function testContinuum()

    local table = {
        www = 75,
        www2 = 25
    }
    local cont = continuum:new(table)
    luaunit.assertEquals(#(cont["sortedkeys"]),320)


    local table2 = {
        ["http://www.bbc.co.uk"] = 75,
        ["http://www.google.co.uk"] = 25,
    }

    local cont2 = continuum:new(table2)
    luaunit.assertEquals(cont2:get("http://www.bbc.co.uk"),"http://www.bbc.co.uk")
    luaunit.assertEquals(cont2:get("www.google.co.uk"),"http://www.google.co.uk")

    local counts = {
        ["http://www.google.co.uk"] = 0,
        ["http://www.bbc.co.uk"] = 0
    }

    local count = 100000
    local uuid = require("utils/uuid")
    local i =1;
    while i<=count do
        local id = uuid()
        counts[cont2:get(id)] = counts[cont2:get(id)] + 1
        i = i +1
    end

    luaunit.assertTrue((counts["http://www.google.co.uk"]/count)*100<30)
    luaunit.assertTrue((counts["http://www.bbc.co.uk"]/count)*100>65)
end

function testJenkinsHash()
    luaunit.assertEquals(jenkins("sausage"),2834523395)
    luaunit.assertEquals(jenkins("blubber"),1103975961)
    luaunit.assertEquals(jenkins("pencil"),3318404908)
    luaunit.assertEquals(jenkins("cloud"),670342857)
    luaunit.assertEquals(jenkins("moon"),2385442906)
    luaunit.assertEquals(jenkins("water"),3403519606)
    luaunit.assertEquals(jenkins("computer"),2375101981);
    luaunit.assertEquals(jenkins("school"),1513618861);
    luaunit.assertEquals(jenkins("network"),2981967937);
    luaunit.assertEquals(jenkins("hammer"),1218821080);
    luaunit.assertEquals(jenkins("this is much large than 12 characters"),1536427952)
    luaunit.assertEquals(jenkins("929794bc-9c37-42aa-8396-4d25ad8e76e1"),2060600931)
    luaunit.assertEquals(jenkins("62b45c80-5140-4d72-9724-c7585d753bca"),120388543)
    luaunit.assertEquals(jenkins("4e68d926-5f23-436c-9913-4ea057160315"),3151318086)
    luaunit.assertEquals(jenkins("6ccdeaf9-fea3-4500-b7ff-88e3eed6359d"),867325236)
    luaunit.assertEquals(jenkins("c62677b3-c7ef-4520-97a0-e9f56230009d"),3171588098)
    luaunit.assertEquals(jenkins("260edfe3-1453-4f6e-b879-a03773204de5"),1543929270)
    luaunit.assertEquals(jenkins("d1b7bece-4c44-48b7-a58f-03ca34d46f86"),3096634272)
    luaunit.assertEquals(jenkins("68c3913b-c266-42f2-943f-07fbb27ff4f9"),4276438567)
    luaunit.assertEquals(jenkins("7c65fd5c-44f4-4272-817b-89a59db82dbc"),309434258)
    luaunit.assertEquals(jenkins("5e46e40f-ae58-44b9-9636-6d040e9d2790"),3281038618)
    luaunit.assertEquals(jenkins("96a3e984-fb38-4d65-ac20-ac27fede88e8"),3580658216)
    luaunit.assertEquals(jenkins("11128088-f4af-4d33-a6ff-2ac27a858d95"),4138923278)
    luaunit.assertEquals(jenkins("e239fd34-788e-435d-bceb-891aa3fa10a5"),2169478175)
    luaunit.assertEquals(jenkins("699324c1-e99a-4acf-a4b4-5feff65a8bcd"),3000550031)
    luaunit.assertEquals(jenkins("85b2d049-c2da-4455-8cd0-2ddcfd72214a"),685539965)
    luaunit.assertEquals(jenkins("0ad16571-6bab-4157-adf7-bf9fb8373c3f"),361025608)
    luaunit.assertEquals(jenkins("4cf03067-09c2-44e0-83b6-5402a1eb9764"),2175326810)
    luaunit.assertEquals(jenkins("1d52b564-b013-401b-809a-d16a07db0e16"),4000534357)
    luaunit.assertEquals(jenkins("4cd62233-4880-4f4d-b571-c5035dc033f9"),942264219)
    luaunit.assertEquals(jenkins("873cf03d-fd35-465c-9aa7-59bac4ddfe23"),1203963860)
    luaunit.assertEquals(jenkins("29c8a485-7b81-4ae2-b98b-68e93d26a272"),118959399)
    luaunit.assertEquals(jenkins("631ba3de-9be1-4128-840c-535c3b13a98d"),1241243625)
    luaunit.assertEquals(jenkins("fd2d3527-1135-4c87-a878-b20e95e483e2"),3680120770)
    luaunit.assertEquals(jenkins("06b002ef-62c2-4c27-bb7c-fda8511506fe"),2201281615)
    luaunit.assertEquals(jenkins("e289db54-f20d-48ec-9426-72de97bf7c3f"),4165794720)
    luaunit.assertEquals(jenkins("979db7f5-e802-439c-a66b-950c67a0ea7b"),3567736096)
    luaunit.assertEquals(jenkins("54949320-493c-45e1-9831-ab8aceee32f7"),3327087292)
    luaunit.assertEquals(jenkins("94e213ab-60a1-401f-81cd-990be86bd79e"),3469278785)
    luaunit.assertEquals(jenkins("aa49ace6-7e91-4f1c-b85b-0552bb4b5ab5"),2559590648)
    luaunit.assertEquals(jenkins("460c2bbf-bf48-4695-809b-2b49e5b4a50f"),4032727907)
    luaunit.assertEquals(jenkins("7061eeb6-af22-463e-b211-2713ca285572"),3751095789)
    luaunit.assertEquals(jenkins("ba1f10ec-b400-4ae9-86b4-a50099e10982"),4020795639)
    luaunit.assertEquals(jenkins("ee52e522-f329-45ca-bf2a-05518e5ec35f"),4017595813)
    luaunit.assertEquals(jenkins("45a32f49-80b0-4f32-95c6-41c82943a8fd"),607628767)
    luaunit.assertEquals(jenkins("0edc522b-b909-4a0f-8a65-da40f228ff2f"),902336057)
    luaunit.assertEquals(jenkins("78a2e503-e347-470a-8638-40621606413c"),4230720652)
    luaunit.assertEquals(jenkins("fb0a68a6-4977-4657-9106-5b7b461711e2"),1781684215)
    luaunit.assertEquals(jenkins("1d0d362e-0808-4d38-9a94-194528067284"),1777874820)
    luaunit.assertEquals(jenkins("4a248679-6b52-42a7-b7c4-14aec1d3ecca"),754151207)
    luaunit.assertEquals(jenkins("5814a6ce-64a1-4793-b2fb-6f3022e001a7"),1409583886)
    luaunit.assertEquals(jenkins("db0010b2-d152-4fd0-8502-384497e362d5"),4170988277)
    luaunit.assertEquals(jenkins("0fe66406-2b2d-420f-904e-cb34574f391a"),420961150)
    luaunit.assertEquals(jenkins("1ca1cd00-62e7-4408-9938-f05e9a7642b9"),3285446238)
    luaunit.assertEquals(jenkins("a92c42e8-f75e-41bd-8181-cbc6a60ccce0"),3791892710)
    luaunit.assertEquals(jenkins("a1e0eb75-720a-40e4-999b-2b297a1878e8"),332726007)
end

os.exit( luaunit.LuaUnit.run() )
