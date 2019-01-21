local component = require("component")
local keyboard = require("keyboard")
local term = require("term")
local gpu = component.gpu
local geo = component.geolyzer
local nav = component.navigation

local out_w = 3

-- кол-во ячеек
-- local cX = 6
-- local cZ = 6
-- local cY = 3
local cX = 3
local cZ = 3
local cY = 16

-- размер ячеек
local dX = 4
local dZ = 4
local dY = 4

local rX = dX*cX
local rZ = dZ*cZ
local rY = dY*cY

local oX = -rX/2
local oZ = -rZ/2
--local oY = -rY/2
local oY = -rY

function math.round(num, numdecimalplaces)
  return tonumber(string.format("%." .. (numdecimalplaces or 0) .. "f", num))
end

while 1 do
  local arrd = {{{}}}
  --local arrd = {{{ {{{ }}} }}}
  for _x = 0,cX-1 do
    for _z = 0,cZ-1 do
      -- local maxd = {{}}
      -- local maxy = {{}}
      for _y = 0,cY-1 do
      --io.write(os.time().." ")
        arrd[_x]         = arrd[_x] or {{}}
        arrd[_x][_z]     = arrd[_x][_z] or {}
        arrd[_x][_z][_y] = arrd[_x][_z][_y] or 0
        arrd[_x][_z][_y] = geo.scan(oX+dX*_x,oZ+dZ*_z,oY+dY*_y,dX,dZ,dY)
      --io.write(os.time().."\n")
      -- for x = 1,dX do
        -- for z = 1,dZ do
        -- -- maxd[x] = maxd[x] or {}
        -- -- maxd[x][z] = maxd[x][z] or 0
        -- -- maxy[x] = maxy[x] or {}
        -- -- maxy[x][z] = maxy[x][z] or 0
        -- for y = 1,dY do
          -- -- arrd[-2+x+dX*_x] = arrd[-2+x+dX*_x] or {{}}
          -- -- arrd[-2+x+dX*_x][-2+z+dZ*_z] = arrd[-2+x+dX*_x][-2+z+dZ*_z] or {}
          -- -- arrd[-2+x+dX*_x][-2+z+dZ*_z][-2+y+dY*_y] = arrd[-2+x+dX*_x][-2+z+dZ*_z][-2+y+dY*_y] or 0
          -- -- arrd[-2+x+dX*_x][-2+z+dZ*_z][-2+y+dY*_y] = d[x+(z-1)*dX+(y-1)*dZ*dX]/iterCount

          -- arrd[_x]                  = arrd[_x] or {{ {{{ }}} }}
          -- arrd[_x][_z]              = arrd[_x][_z] or { {{{ }}} }
          -- arrd[_x][_z][_y]          = arrd[_x][_z][_y] or {{{}}}
          -- arrd[_x][_z][_y][x]       = arrd[_x][_z][_y][x] or {{}}
          -- arrd[_x][_z][_y][x][z]    = arrd[_x][_z][_y][x][z] or {}
          -- arrd[_x][_z][_y][x][z][y] = arrd[_x][_z][_y][x][z][y] or 0
          -- arrd[_x][_z][_y][x][z][y] = arrd[_x][_z][_y][x][z][y] + d[x+(z-1)*dX+(y-1)*dZ*dX]/iterCount
          -- -- if d[x+(z-1)*dX+(y-1)*dZ*dX] > maxd[x][z] then 
          -- -- maxy[x][z] = -2+dY*_y+y
          -- -- maxd[x][z] = d[x+(z-1)*dX+(y-1)*dZ*dX]
          -- -- end
        -- end
        -- end
      -- end

      end

      -- for x = 1,dX do
        -- for z = 1,dZ do
        -- gpu.setBackground(math.min(math.round(maxd[x][z]*2),15),true)
        -- if maxy[x][z] >= 0 then
          -- gpu.set(10+(x+dX*_x)*2,10+z+dZ*_z," "..maxy[x][z])
        -- else
          -- gpu.set(10+(x+dX*_x)*2,10+z+dZ*_z,""..maxy[x][z])
        -- end
        -- end
      -- end
      
    end 
  end
  local dir = nav.getFacing()-1
  for _z = 0,cZ-1 do
    for _x = 0,cX-1 do

      for z = 1,dZ do
        for x = 1,dX do
  --         local maxd = 0		--\
  --         local mind = 1000	--\
  --         local avgd = 0		--for dispd and dispy
  --         local dispd = nil	--for colorize out
  -- 
  --         local maxy = 0		--\
  --         local miny = 0		--for dispy
          local dispy --for heigth

          local px = ({(	x+dX*_x)*out_w,	(rX+1-(x+dX*_x))*out_w,	(rZ+1-(z+dZ*_z))*out_w,	(z+dZ*_z)*out_w		})[dir]
          local pz = ({	z+dZ*_z,	rZ+1-(z+dZ*_z),		x+dX*_x,			rX+1-(x+dX*_x)	})[dir]
          local c

          local _d = 13 -- best d
          local bd = 1000
          local d
          for _y = 0,cY-1 do
            for y = 1,dY do
              d = arrd[_x][_z][_y][x+(z-1)*dX+(y-1)*dZ*dX]
    --             avgd = avgd + d/rY


              if d == 1 then
                _d = 1
              elseif d == 2 then
                _d = 2
              elseif d == 3 then
                _d = 3
              elseif d == 4 then
                _d = 4
              elseif d == 50 then
                _d = 5
              elseif d == 100 then
                _d = 6
              elseif d == 0 then
                _d = 7
              elseif 0 < d and d < 1 then
                _d = 8
              elseif 1 < d and d < 2 then
                _d = 9
              elseif 2 < d and d < 3 then
                _d = 10
              elseif 3 < d and d < 4 then
                _d = 11
              elseif 4 < d and d < 5 then
                _d = 12
              end
              if _d < bd then
                bd = _d
                dispy = oY+dY*_y+y
              end

    --             if d > maxd then 
    --               maxy = oY+dY*_y+y
    --               maxd = d
    -- 
    --             elseif d < mind then 
    --               miny = oY+dY*_y+y
    --               mind = d
    --             end
            end -- y
          end -- _y

          c = ({1,4,5,13,14,11,15,2,3,9,10,12})[bd]
          if  ({1,4,5})[bd] then
            gpu.setForeground(15,true)
          else
            gpu.setForeground(0,true)
          end
    --         dispd = maxd - mind
    --         if (maxd-avgd > avgd-mind) then
    --           dispy = miny
    --         else
    --           dispy = maxy
    --         end

          --c = math.min(math.round(dispd*3.75),15)

          gpu.setBackground(c,true)
          if out_w == 2 then
            if x+dX*_x-1 == rX/2 and z+dZ*_z-1 == rZ/2 then
              gpu.set(px,pz,"##")
            elseif dispy >= 0 then
              gpu.set(px,pz," "..dispy)
            else
              gpu.set(px,pz,""..dispy)
            end
          elseif out_w == 3 then
            local out = ""..dispy
            if math.abs(dispy) < 10 then
              out = out.." "
            end
            if x+dX*_x-1 == rX/2 and z+dZ*_z-1 == rZ/2 then
              out = "###"
            elseif dispy >= 0 then
              out = " "..out
            end
            gpu.set(px,pz,out)
          end
        end --x
      end --z
    end --_x
  end --_z
  os.sleep(0.1)
  if keyboard.isKeyDown(keyboard.keys.q) then
    gpu.setForeground(0xFFFFFF)
    gpu.setBackground(0x000000)
    term.clear()
    break
  end
end
