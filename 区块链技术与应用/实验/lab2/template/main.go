package main

import (
	"bufio"
	"fmt"
	"github.com/urfave/cli"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	bc := NewBlockchain()
	//  defer 会在当前函数返回前执行传入的函数
	// 这里用以在函数返回前关闭数据库连接
	defer bc.db.Close()

	// cli := CLI{bc}

	// cli.Run()
	app := cli.NewApp()
	app.Name = "chaincode"

	app.Action = func(c *cli.Context) {
		if c.NArg() != 0 {
			fmt.Printf("未找到命令: %s\n运行命令 %s help 获取帮助\n", c.Args().Get(0), app.Name)
			return
		}
		
		var prompt  string
		
		prompt = app.Name + " > "
		L:
      for {
        var input   string		
    		fmt.Print(prompt)
      //   fmt.Scanln(&input)

        scanner := bufio.NewScanner(os.Stdin)
        scanner.Scan() // use `for scanner.Scan()` to keep reading
        input = scanner.Text()
        //fmt.Println("captured:",input)
      	switch input {
        	case "close":
        		fmt.Println("close.")
        		break L
        	default:
      	}
        // fmt.Println(input)
  			cmdArgs := strings.Split(input, " ")
  		//   fmt.Println(len(cmdArgs))
  			if len(cmdArgs) == 0 {
  				continue
  			}
  			
  		 	s := []string{app.Name}
  		 	s = append(s,cmdArgs...)

			c.App.Run(s)
			  
      }

  return 
  }

  app.Commands = []cli.Command {
	  {
		  Name: "addblock",
		  Aliases: []string{"a"},
		  Usage: "addblock BLOCK_DATA    - add a block to the blockchain",
		  Action: func(c *cli.Context) error {
			  data := c.Args()
			  bc.AddBlock(data)
			  fmt.Println("add Success")
			  return nil
		  },
	  },
	  {
		  Name: "printchain",
		  Aliases: []string{"p"},
		  Usage: "printchain",
		  Action: func(c *cli.Context) error {
			  bci := bc.Iterator()
			  for {
				block := bci.Next()
		
				fmt.Printf("Prev. hash: %x\n", block.PrevBlockHash)
				fmt.Printf("Data: %s\n", block.Data)
				fmt.Printf("Hash: %x\n", block.Hash)
				pow := NewProofOfWork(block)
				fmt.Printf("PoW: %s\n", strconv.FormatBool(pow.Validate()))
				fmt.Println()
		
				if len(block.PrevBlockHash) == 0 {
					break
				}
			}
			  return nil
		  },
	  },
	  {
		Name:        "template",
		Aliases:     []string{"t"},
		Usage:       "options for task templates",
		Subcommands: []cli.Command {
			{
				Name: "addblock",
				Aliases: []string{"a"},
				Usage: "addblock BLOCK_DATA    - add a block to the blockchain",
				Action: func(c *cli.Context) error {
					data := c.Args()
					bc.AddBlock(data)
					fmt.Println("add Success")
					return nil
				},
			},
			{
				Name: "printchain",
				Aliases: []string{"p"},
				Usage: "printchain",
				Action: func(c *cli.Context) error {
					bci := bc.Iterator()
					for {
					  block := bci.Next()
			  
					  fmt.Printf("Prev. hash: %x\n", block.PrevBlockHash)
					  fmt.Printf("Data: %s\n", block.Data)
					  fmt.Printf("Hash: %x\n", block.Hash)
					  pow := NewProofOfWork(block)
					  fmt.Printf("PoW: %s\n", strconv.FormatBool(pow.Validate()))
					  fmt.Println()
			  
					  if len(block.PrevBlockHash) == 0 {
						  break
					  }
				  }
					return nil
				},
			},
		},
	  },
  }

  err := app.Run(os.Args)
  
  if err != nil {
    log.Fatal(err)
  }

}
