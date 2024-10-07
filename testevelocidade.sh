#!/bin/bash

# URL para download do arquivo de teste
url="http://speedtest.tele2.net/100MB.zip"

# Diretório temporário para armazenar o arquivo de teste
temp_file="/tmp/testfile"

# Exibe a mensagem inicial
echo "Iniciando o teste de velocidade de download..."

# Medir a latência com ping
ping_host="8.8.8.8"  # Google DNS
latency=$(ping -c 4 $ping_host | tail -1 | awk '{print $(NF-1)}' | sed 's/[^0-9.]//g')

# Faz o download do arquivo usando wget com a opção --progress=dot
start_time=$(date +%s)
wget --output-document=$temp_file --progress=dot "$url"
end_time=$(date +%s)

# Calcula o tempo total gasto no download
time_taken=$((end_time - start_time))

# Tamanho do arquivo em MB
file_size=$(du -m $temp_file | cut -f1)

# Calcula a velocidade em MBps (Megabytes por segundo)
speed=$(echo "scale=2; $file_size / $time_taken" | bc)

# Exibe os resultados
echo ""
echo "Teste concluído!"
echo "Tempo total gasto: $time_taken segundos"
echo "Tamanho do arquivo: $file_size MB"
echo "Velocidade de download: $speed MB/s"
echo "Latência (ping para $ping_host): $latency ms"

# Remove o arquivo temporário
rm $temp_file
