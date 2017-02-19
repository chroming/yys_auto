-- 适用屏幕参数
SCREEN_RESOLUTION="1536x2048";
SCREEN_COLOR_BITS=32;

mr = math.random

function snapshotScreen(x)
    return false
end

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

-- 查找指定图片
function find_image(img)
    x, y = findImage(img);
    if x ~= -1 and y ~= -1 then
        return true;
    end
end

-- 胜利点击
function shengli()
    notifyMessage("战斗结束点击", 500);
    snapshotScreen(string.format( "/var/touchelf/log/%s_%s.jpg","战斗结束点击", os.time()));
    slp(1);
    click(mr(240, 500), mr(500, 1500));  -- 结束点击
    notifyMessage("抽奖点击", 500);
    snapshotScreen(string.format( "/var/touchelf/log/%s_%s.jpg","抽奖点击", os.time()));
    slp(1);
    
    click(mr(240, 500), mr(500, 1500));  -- 抽奖点击
    notifyMessage("抽奖结束点击", 500);
    snapshotScreen(string.format( "/var/touchelf/log/%s_%s.jpg","抽奖结束点击",os.time()));
    slp(1);
    
    click(mr(240, 500), mr(500, 1500));  -- 抽奖结束点击
end

-- 失败点击
function shibai()
    notifyMessage("失败点击", 500);
    snapshotScreen(string.format( "/var/touchelf/log/%s_%s.jpg","失败点击",os.time()));
    slp(1);
    click(mr(240, 500), mr(500, 1500));  -- 失败 点击
end

-- 点击挑战
function tiaozhan()
    notifyMessage("点击挑战", 500)
    snapshotScreen(string.format( "/var/touchelf/log/%s_%s.jpg","点击挑战",os.time()));
    slp(1);
    click(mr(510, 580), mr(1430, 1570)); --挑战
    slp(1);
    tilibuzu_find = find_image("tilibuzu.bmp");
    if tilibuzu_find == true then
        notifyMessage("体力不足!等待8000000秒!", 5000);
        snapshotScreen(string.format( "/var/touchelf/log/%s_%s.jpg","体力不足!等待8000000秒!",os.time()));
        mSleep(8000000);
        click(mr(1000, 1050), mr(1470, 1530));
        notifyMessage("等待结束", 500)
        snapshotScreen(string.format( "/var/touchelf/log/%s_%s.jpg","等待结束",os.time()));
        return tiaozhan()
    end
end
-- 主函数入口
function main()
    rotateScreen(0);
    tiaozhan()

    notifyMessage("点击准备", 500);
    snapshotScreen(string.format( "/var/touchelf/log/%s_%s.bmp","点击准备",os.time()));
    mSleep(math.random(7000, 10000));
    
    click(mr(240, 320), mr(1800, 1900)); -- 准备
    snapshotScreen(string.format( "/var/touchelf/log/%s_%s.jpg","准备",os.time()));
    slp(1);
    notifyMessage("战斗中", 500);
    snapshotScreen(string.format( "/var/touchelf/log/%s_%s.jpg","战斗中",os.time()));
    
    while(true)
    do
        shengli_find = find_image("shengli.bmp")
        shibai_find = find_image("shibai.bmp")
        snapshotScreen(string.format( "/var/touchelf/log/%s_%s.jpg","搜索图片",os.time()));
        if shengli_find == true then
            shengli();
            break
        elseif shibai_find == true then
            shibai();
            break
        end
        mSleep(5000)
    end
    
    notifyMessage("冷却时间", 500)
    snapshotScreen(string.format( "/var/touchelf/log/%s_%s.jpg","冷却时间",os.time()));
    mSleep(math.random(10000, 20000));
end