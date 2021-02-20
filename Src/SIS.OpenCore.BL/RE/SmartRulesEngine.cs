﻿using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using RulesEngine.Models;
using SIS.OpenCore.BL.RE.Helper;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.IO;
using static RulesEngine.Extensions.ListofRuleResultTreeExtension;

namespace SIS.OpenCore.BL.RE
{
    class SmartRulesEngine
    {
        public static void Run(object inputOne, Dictionary<string, string> fields)
        {
            #region load Rule file and load it
            var files = Directory.GetFiles(Directory.GetCurrentDirectory() + "", "CIFRules.json", SearchOption.AllDirectories);
            if (files == null || files.Length == 0)
                throw new Exception("Rules not found.");
            var fileData = File.ReadAllText(files[0]);
            var workflowRules = JsonConvert.DeserializeObject<List<WorkflowRules>>(fileData);
            #endregion

            #region load paramters and run engine
            var inputs = new RuleParameter[2];
            // this is the mapping between the name in expression and the object
            inputs[0] = new RuleParameter("CIF", inputOne);
            inputs[1] = new RuleParameter("fields", fields); 

            var reSettingsWithCustomTypes = new ReSettings { CustomTypes = new Type[] { typeof(REDBUtils) } };
            var bre = new RulesEngine.RulesEngine(workflowRules.ToArray(), null, reSettingsWithCustomTypes) ;
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
