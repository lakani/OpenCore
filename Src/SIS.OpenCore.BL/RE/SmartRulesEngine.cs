using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using RulesEngine.Models;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.IO;
using static RulesEngine.Extensions.ListofRuleResultTreeExtension;

namespace SIS.OpenCore.BL.RE
{
    class SmartRulesEngine
    {
        public static void Run(object inputOne)
        {
            #region load Rule file and load it
            var files = Directory.GetFiles(Directory.GetCurrentDirectory() + "", "CIFRules.json", SearchOption.AllDirectories);
            if (files == null || files.Length == 0)
                throw new Exception("Rules not found.");
            var fileData = File.ReadAllText(files[0]);
            var workflowRules = JsonConvert.DeserializeObject<List<WorkflowRules>>(fileData);
            var bre = new RulesEngine.RulesEngine(workflowRules.ToArray(), null);
            #endregion

            #region load paramters and run engine
            var inputs = new RuleParameter[1];
            // this is the mapping between the name in expression and the object
            inputs[0] = new RuleParameter("CIF", inputOne);
            
            List<RuleResultTree> resultList = bre.ExecuteAllRulesAsync("CIFPOST", inputs).Result;
            #endregion

            #region check the return of rules
            foreach(var ruleRet in resultList)
            {
                if(ruleRet.IsSuccess == false)
                {
                    throw new Exception(ruleRet.ExceptionMessage);
                }
            }

            #endregion
        }
    }
}
