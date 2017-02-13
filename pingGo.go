package main

import (
    "fmt"
    "net"
    "time"
    "os"
    "github.com/tatsushid/go-fastping"
    "log"
    "bufio"
)

const fileName = "hosts/hosts.txt"

func main() {
    lines, err := readFile()
    if err != nil {
        log.Fatalf("readLines: %s", err)
    }else{
        startPinging(lines)
    }


}

func readFile() ([]string, error) {
  file, err := os.Open(fileName)
  if err != nil {
    return nil, err
  }
  defer file.Close()

  var lines []string
  scanner := bufio.NewScanner(file)
  for scanner.Scan() {
    lines = append(lines, scanner.Text())
  }
  return lines, scanner.Err()
}

func startPinging(hostAddress []string){
    ticker := time.NewTicker(time.Second * 5)
    go func() {
        for t := range ticker.C {
            for i, line := range hostAddress {
              fmt.Println(i+1, line + " " + t.String() )
              fmt.Printf("Tick at %s , result is %s \n", t, ping(line))
            }
            fmt.Println()
        }
    }()
    time.Sleep(time.Second * 55)
    ticker.Stop()
    fmt.Println("Ticker stopped")
}


func ping(hostAddress string)(string){
    p := fastping.NewPinger()
    ra, err := net.ResolveIPAddr("ip4:icmp", hostAddress)
    if err != nil {
        fmt.Println(err)
        return err.Error()
        //os.Exit(1)
    } 
    p.AddIPAddr(ra)
    p.OnRecv = func(addr *net.IPAddr, rtt time.Duration) {
        fmt.Printf("IP Addr: %s receive, RTT: %v\n", addr.String(), rtt)
    }

    err = p.Run()
    if err != nil {
        return err.Error()
    }
    return "Ok"
}


