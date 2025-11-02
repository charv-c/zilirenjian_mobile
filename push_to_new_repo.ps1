# 推送到新仓库的脚本
# 这个脚本会将当前分支推送到新仓库，不会影响原来的origin仓库

Write-Host "检查Git状态..." -ForegroundColor Green

# 检查是否有未提交的更改
$status = git status --porcelain
if ($status) {
    Write-Host "发现未提交的更改，是否要提交？(Y/N)" -ForegroundColor Yellow
    $response = Read-Host
    if ($response -eq "Y" -or $response -eq "y") {
        Write-Host "添加所有更改..." -ForegroundColor Green
        git add .
        
        Write-Host "请输入提交信息：" -ForegroundColor Yellow
        $commitMsg = Read-Host
        if ([string]::IsNullOrWhiteSpace($commitMsg)) {
            $commitMsg = "Update files"
        }
        
        git commit -m $commitMsg
        Write-Host "已提交更改" -ForegroundColor Green
    }
}

# 获取当前分支名
$currentBranch = git branch --show-current
if ([string]::IsNullOrWhiteSpace($currentBranch)) {
    $currentBranch = "master"
}

Write-Host "当前分支: $currentBranch" -ForegroundColor Cyan
Write-Host "准备推送到新仓库: https://github.com/charv-c/zilirenjian_mobile.git" -ForegroundColor Cyan

# 推送当前分支到新仓库
Write-Host "正在推送..." -ForegroundColor Green
git push new-origin $currentBranch

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n成功推送到新仓库！" -ForegroundColor Green
    Write-Host "新仓库地址: https://github.com/charv-c/zilirenjian_mobile.git" -ForegroundColor Green
    Write-Host "原来的仓库保持不变: https://github.com/charv-c/2025taptapjam.git" -ForegroundColor Green
} else {
    Write-Host "`n推送失败，请检查：" -ForegroundColor Red
    Write-Host "1. 是否已经登录GitHub" -ForegroundColor Yellow
    Write-Host "2. 是否有推送权限" -ForegroundColor Yellow
    Write-Host "3. 新仓库是否已经创建" -ForegroundColor Yellow
}

