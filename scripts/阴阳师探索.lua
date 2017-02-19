-- 适用屏幕参数
SCREEN_RESOLUTION="1536x2048";
SCREEN_COLOR_BITS=32;

mr = math.random

-- 暂停
function slp(reg)
    return mSleep(lrantime(reg));
end

-- 随机时间
function lrantime(reg)
    if reg == 1 then
        return mr(1232, 5345);
    elseif reg == 0 then
        return mr(93, 845);
    elseif reg == 2 then
        return mr(1000, 5000)
    else
        return false;
    end
end
-- 点击函数
function click(x, y)
    touchDown(0, x, y);
    mSleep(lrantime(0));
    touchUp(0);
end

-- 添加随机数的点击
function click_r(x, y, a, b)
	a = a or 3
	b = b or 10
    return click(x+mr(3,10), y+mr(3,10))
end
-- 滑动界面 -- 有问题暂不启用
function move(x, y, x1, y1)
    touchDown(0, x, y)
    mSleep(lrantime(0))
    touchMove(0, x1, y1)
    mSleep(lrantime(0))
    touchUp(0)
end

-- 查找指定图片
function find_image(img)
    x, y = findImage(img);
    if x ~= -1 and y ~= -1 then
        return true;
    end
end

-- 查找胜利标识颜色
function find_win_colors()
    x, y = findMultiColorInRegionFuzzy({ 0x9E1C12, 50, -1, 0xC7B5A0, 83, -6, 0x801910, 102, 87, 0xC0AC95, 102, 106, 0x8C2317, 17, 139, 0x991C12, -39, 81, 0xD6C8AF, 30, 52, 0xCEBFAB }, 90, 1100, 600, 1400, 900);
    if x ~= -1 and y ~= -1 then
        return true;
    end
end

-- 查找失败标识颜色
function find_lose_colors()
    x, y = findMultiColorInRegionFuzzy({ 0x62596E, 7, 26, 0x240B08, 7, 133, 0x5D5367, 73, 171, 0x9F8870, 116, 105, 0xA8927C, 120, 12, 0x4A4251, 92, -21, 0x554E60, 58, 60, 0xB9A790 }, 90, 1100, 600, 1400, 900);
    if x ~= -1 and y ~= -1 then
        return true;
    end
end
-- 胜利点击
function shengli()
    notifyMessage("战斗结束点击", 500);
    slp(1);
    click(mr(240, 500), mr(500, 1500));  -- 结束点击
    notifyMessage("抽奖点击", 500);
    slp(1);
    
    click(mr(240, 500), mr(500, 1500));  -- 抽奖点击
    notifyMessage("抽奖结束点击", 500);
    slp(1);
    
    click(mr(240, 500), mr(500, 1500));  -- 抽奖结束点击
end

-- 失败点击
function shibai()
    notifyMessage("失败点击", 500);
    slp(1);
    click(mr(240, 500), mr(500, 1500));  -- 失败 点击
end

-- 等待战斗结束
function wait_result()
    while(true)
    do
        -- shengli_find = find_image("shengli.bmp")
        -- shibai_find = find_image("shibai.bmp")
        win_find = find_win_colors()
        lose_find = find_lose_colors()
        -- snapshotScreen(string.format( "/var/touchelf/log/%s_%s.bmp","搜索图片",os.time()));
        if win_find == true then
            shengli();
            break
        elseif lose_find == true then
            shibai();
            break
        end
        mSleep(5000)
    end
end

-- 点击准备
function zhunbei()
    notifyMessage("点击准备", 500);
    mSleep(math.random(7000, 10000));
    click(mr(240, 320), mr(1800, 1900)); -- 准备
    slp(2);
    notifyMessage("战斗中", 500);
    
    wait_result()
end


function main()
    rotateScreen(0);
    
    notifyMessage("找怪", 500);
    slp(1);
    
    while(true)
    do
        -- keepScreen(true);
        slp(2)
        x, y = findMultiColorInRegionFuzzy({ 0xFEF5E9, 20, 6, 0xBF383A, 41, 10, 0x452B5B, 55, 50, 0x9C1A1C, 44, 61, 0x462B52 }, 80, 100, 20, 1300, 2000)
        if x ~= -1 and y ~= -1 then
            -- keepScreen(false);
            -- notifyMessage("找到boss", 500);
            slp(2)
            click_r(x,y);
            slp(1);
            zhunbei();
            break
        else
            -- x, y = findImage('tssmall.bmp');
            -- x, y = findMultiColorInRegionFuzzy({0xEB9DA5, 50, 0, 0x444E83, 80, 10, 0xEEA4AD, 50, 35, 0xE0E1F8, 35, 50, 0xCD777B}, 80, 100, 20, 1300, 2000)
            x, y = findMultiColorInRegionFuzzy({ 0xDEDFFB, 19, 1, 0x282C5A, 29, 31, 0xB3B3DD, 24, 41, 0xD8D9F4, 52, 16, 0xE899A1, -18, 6, 0xF4B1BB, 9, 58, 0xCA7578, 44, 55, 0xD0AB54 }, 80, 100, 20, 1300, 2000);
            if x ~= -1 and y ~= -1 then
                -- keepScreen(false);
                -- notifyMessage("找到小怪", 5);
                click_r(x,y);
                slp(1);
                zhunbei();
            else
            	notifyMessage("开始移动", 500);
                slp(2);
                -- keepScreen(false);
                if now_color0 ~= getColor(1200, 1900) or now_color1 ~= getColor(1300, 1800) or now_color2 ~= getColor(1000, 1500) then
                	click_r(300, 1900);
                	now_color0 = getColor(1200, 1900)
                	now_color1 = getColor(1300, 1800)
                	now_color2 = getColor(1000, 1500)
                else
                	notifyMessage("啥都没有了", 500)
                	break
                end
            end
        end
    end
    
    notifyMessage("冷却时间", 500)
    mSleep(math.random(10000, 20000));
    
end
    

