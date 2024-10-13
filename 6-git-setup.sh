#!/bin/bash
set -e
#######################################################
# Author    : Ahmet Önder Moğol
# Description: Bu script, Git ve SSH ayarlarını yapılandırır
#              ve gerekli araçları yükler.
#######################################################

# .env dosyasını yükle
if [ -f .env ]; then
    export $(cat .env | xargs)
else
    echo ".env dosyası bulunamadı. Lütfen .env dosyasını oluşturun."
    exit 1
fi

# Gerekli değişkenlerin tanımlandığından emin ol
if [ -z "$GIT_USER_NAME" ] || [ -z "$GIT_USER_EMAIL" ]; then
    echo "Hata: GIT_USER_NAME veya GIT_USER_EMAIL tanımlanmamış."
    echo "Lütfen .env dosyasında bu değişkenleri tanımladığınızdan emin olun."
    exit 1
fi

# Hata yakalama fonksiyonu
handle_error() {
    echo "Hata: $1" >&2
    exit 1
}

# xclip'in yüklü olup olmadığını kontrol et
if ! command -v xclip &> /dev/null
then
    echo "xclip bulunamadı. Yükleniyor..."
    sudo pacman -Sy xclip --noconfirm || handle_error "xclip yüklenemedi"
else
    echo "xclip zaten yüklü."
fi

# SSH anahtarı oluşturma
if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "SSH anahtarı oluşturuluyor..."
    ssh-keygen -t ed25519 -C "$GIT_USER_EMAIL" || handle_error "SSH anahtarı oluşturulamadı"
else
    echo "SSH anahtarı zaten mevcut. Yeni bir anahtar oluşturmak ister misiniz? (e/h)"
    read -r response
    if [[ "$response" =~ ^([eE][vV][eV][tT]|[eE])$ ]]; then
        ssh-keygen -t ed25519 -C "$GIT_USER_EMAIL" || handle_error "SSH anahtarı oluşturulamadı"
    fi
fi

# SSH ajanını başlatma ve anahtarı ekleme
echo "SSH ajanı başlatılıyor ve anahtar ekleniyor..."
eval "$(ssh-agent -s)" || handle_error "SSH ajanı başlatılamadı"
ssh-add ~/.ssh/id_ed25519 || handle_error "SSH anahtarı eklenemedi"

# Genel anahtarı kopyalama
echo "Genel anahtar panoya kopyalanıyor..."
cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard || handle_error "Genel anahtar kopyalanamadı"

# Git konfigürasyonu
echo "Git konfigürasyonu yapılıyor..."

# Git kullanıcı adını ayarla
if git config --global user.name "$GIT_USER_NAME"; then
    echo "Git kullanıcı adı başarıyla ayarlandı: $GIT_USER_NAME"
else
    handle_error "Git kullanıcı adı ayarlanamadı"
fi

# Git e-posta adresini ayarla
if git config --global user.email "$GIT_USER_EMAIL"; then
    echo "Git e-posta adresi başarıyla ayarlandı: $GIT_USER_EMAIL"
else
    handle_error "Git e-posta adresi ayarlanamadı"
fi

# Mevcut ayarları göster
echo "Güncel Git konfigürasyonu:"
git config --global --get user.name
git config --global --get user.email

# SSH kullanımı için yapılandırma
git config --global core.sshCommand "ssh -i ~/.ssh/id_ed25519" || handle_error "SSH komutu ayarlanamadı"

# HTTPS yerine SSH kullanmak için URL'leri yeniden yazma
git config --global url."git@github.com:".insteadOf "https://github.com/" || handle_error "GitHub URL'si ayarlanamadı"
git config --global url."git@gitlab.com:".insteadOf "https://gitlab.com/" || handle_error "GitLab URL'si ayarlanamadı"

# Eski kimlik doğrulama ayarlarını kaldırma
if git config --global --get credential.helper > /dev/null; then
    git config --global --unset credential.helper || handle_error "Eski kimlik doğrulama ayarları kaldırılamadı"
    echo "Eski kimlik doğrulama ayarları kaldırıldı."
else
    echo "Eski kimlik doğrulama ayarları zaten mevcut değil."
fi

echo "Tüm işlemler başarıyla tamamlandı!"
echo "Lütfen GitHub veya GitLab hesabınıza SSH anahtarını eklemeyi unutmayın."
echo "Kopyalanan genel anahtarı hesap ayarlarınızdaki 'SSH and GPG keys' bölümüne ekleyin."



# GitHub veya GitLab hesabınıza SSH anahtarını ekleme:
# Hesap ayarlarınıza gidin
# "SSH and GPG keys" bölümünü bulun
# "New SSH key" veya "Add SSH key" butonuna tıklayın
# Kopyaladığınız anahtarı yapıştırın ve kaydedin
#  Git yapılandırma dosyanızı güncelleyin:

# Bu değişiklikler:
# 1. SSH anahtarınızı belirtir.
# 2. GitHub ve GitLab için HTTPS yerine SSH kullanmayı sağlar.
# 3. Eski kimlik doğrulama ayarlarını kaldırır.
# Bu ayarları yaptıktan sonra, Git işlemlerinizi şifre girmeden SSH üzerinden gerçekleştirebilirsiniz.